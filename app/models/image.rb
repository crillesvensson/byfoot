class Image < ActiveRecord::Base

	belongs_to :place

	has_attached_file :image, styles: { small: "150x150>", medium: "250x250>" },
                  url: "/assets/users/:id/:style/:basename.:extension",
                  path: ":rails_root/public/assets/users/:id/:style/:basename.:extension" 
  
  	validates_attachment_size :image, less_than: 5.megabytes
  	validates_attachment_content_type :image, content_type: ['image/jpeg', 'image/png']

end
