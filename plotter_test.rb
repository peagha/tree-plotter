# fronzen_string_literals: true

require 'minitest/autorun'
require_relative 'plotter'

class PloterTest < Minitest::Test
  Plotable = Struct.new(:label, :children) do
    def initialize(*)
      super
      self.children ||= []
    end
  end

  def test_plot_single_item
    item = Plotable.new('Item label', [])

    assert_equal "Item label\n", Plotter.plot_tree(item)
  end

  def test_plot_single_item_with_single_child
    child = Plotable.new('Child label')
    parent = Plotable.new('Parent label', [child])

    plot_result = <<~TREE
      Parent label
      └─ Child label
    TREE
    assert_equal plot_result, Plotter.plot_tree(parent)
  end

  def test_plot_single_item_with_multiple_child
    child1 = Plotable.new('Child label 1')
    child2 = Plotable.new('Child label 2')
    child3 = Plotable.new('Child label 3')
    parent = Plotable.new('Parent label', [child1, child2, child3])

    plot_result = <<~TREE
      Parent label
      ├─ Child label 1
      ├─ Child label 2
      └─ Child label 3
    TREE
    assert_equal plot_result, Plotter.plot_tree(parent)
  end

  def test_plot_single_item_with_granchild
    granchild = Plotable.new('Granchild label')
    child = Plotable.new('Child label', [granchild])
    parent = Plotable.new('Parent label', [child])

    plot_result = <<~TREE
      Parent label
      └─ Child label
         └─ Granchild label
    TREE
    assert_equal plot_result, Plotter.plot_tree(parent)
  end
end
