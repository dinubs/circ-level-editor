class Game < ActiveRecord::Base

  before_save :generate_token, :create_artwork

  validates :name, :map, :presence => true
  belongs_to :user

  def self.default_scope
    order created_at: "desc"
  end

  def setup_map str, width
    self.map = str.delete!(",").chars.to_a
                  .each_slice(width.to_i)
                  .to_a.map {|s| s.to_s }
  end

  def image_url
    "https://s3-us-west-2.amazonaws.com/circ-images/game__#{self.token}.jpg"
  end

  def to_partial_path
    'games/game_item'
  end

  def create_artwork
    tile_colors = ["#333", "#888", "#555", "#C93232", "rgba(121, 220, 242, 0.4)", "#E373FA", "#ffc61e"]
    tile_size = 10

    image = Magick::Image.new(210, 120)
    gc = Magick::Draw.new
    temp_map = self.map
    chars = temp_map.delete("\\\\ \",[").split("]")
    gc.fill("#333")
    gc.rectangle(0,0,210,120)
    chars.each_with_index do |y, yIndex|
      yIndex = yIndex + 1
      y.chars.to_a.each_with_index do |xChar, xIndex|
        xIndex = xIndex + 1

        gc.fill(tile_colors[xChar.to_i])
        gc.rectangle( xIndex * tile_size, 
                      yIndex * tile_size, 
                      (xIndex * tile_size) + tile_size, 
                      (yIndex * tile_size) + tile_size)

      end
    end
    gc.draw(image)
    file_name = "game__#{self.token}.jpg"
    image.write(file_name)

    Aws::Uploader.upload(file_name)
  end

protected

  def generate_token
    self.token = SecureRandom.urlsafe_base64
    generate_token if Game.exists?(token: self.token)
  end

end
