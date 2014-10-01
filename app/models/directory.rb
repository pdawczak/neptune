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

  def to_s
    name
  end

  def accessible_ancestors
    ancestors - [root]
  end

  def accessible_ancestors_and_self
    ancestors_and_self - [root]
  end

  def up_dir
    parent.dup.tap do |up|
      up.name = '..'
    end if parent?
  end

  def up_dir?
    parent?
  end

  def content
    content = []
    content << up_dir if up_dir?
    content + children
  end

  private

  def rebuild_path!
    self.path = build_path
  end

  def build_path
    accessible_ancestors_and_self.collect(&:slug).join('/')
  end
end
