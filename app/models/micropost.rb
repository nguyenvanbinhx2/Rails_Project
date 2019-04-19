class Micropost < ApplicationRecord
  belongs_to :user
  default_scope ->{order(created_at: :desc)}
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum:
                                                    Settings.maximum_length_content_ }
  scope :micropost_desc, ->{order created_at: :desc}
  scope :feed, (lambda do |user|
    where user_id: user.id
  end)

  mount_uploader :picture, PictureUploader

  private

  def picture_size
    return unless picture.size > Settings.post.image_size.megabytes
    errors.add(:picture, t("microposts.controller.image_size_content"))
  end
end
