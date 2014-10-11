class Directory
  include Mongoid::Document
  include Mongoid::Tree
  include Mongoid::Slug

  validates :name, presence: true
  validates :name, uniqueness: { scope: :parent_id }

  before_create :rebuild_path!
  before_update :rebuild_path!
  after_rearrange :rebuild_path!

  field :name
  field :path

  slug :name

  index({ path: 1 }, { unique: true })

  class << self
    def name_available?(directory_id, name)
      ! where(parent: directory_id, name: name).exists?
    end
  end

  def to_s
    name
  end

  def accessible_ancestors
    ancestors - [root]
  end

  def accessible_ancestors_and_self
    ancestors_and_self - [root]
  end

  alias_method :up_dir?, :parent?

  def up_dir
    parent.dup.tap do |up|
      up.name = '..'
    end if up_dir?
  end

  def content
    ([up_dir] + children).compact
  end

  private

  def rebuild_path!
    self.path = build_path
  end

  def build_path
    accessible_ancestors_and_self.collect(&:slug).join('/')
  end
end
