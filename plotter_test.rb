# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'plotter'

class PlotterTest < Minitest::Test
  def test_plot_single_item
    item = { label: 'Item' }

    assert_equal "Item\n", Plotter.plot_tree(item)
  end

  def test_plot_single_child
    tree = {
      label: 'Parent',
      children: [{ label: 'Child' }]
    }

    plot_result = <<~TREE
      Parent
      └─ Child
    TREE
    assert_equal plot_result, Plotter.plot_tree(tree)
  end

  def test_plot_multiple_children
    tree = {
      label: 'Parent',
      children: [
        { label: 'Child 1' },
        { label: 'Child 2' },
        { label: 'Child 3' }
      ]
    }

    plot_result = <<~TREE
      Parent
      ├─ Child 1
      ├─ Child 2
      └─ Child 3
    TREE
    assert_equal plot_result, Plotter.plot_tree(tree)
  end

  def test_plot_granchild
    granchild = { label: 'Granchild' }
    tree = {
      label: 'Parent',
      children: [{ label: 'Child', children: [granchild] }]
    }

    plot_result = <<~TREE
      Parent
      └─ Child
         └─ Granchild
    TREE
    assert_equal plot_result, Plotter.plot_tree(tree)
  end

  def test_plot_multiple_granchildren
    granchildren = [
      { label: 'Granchild 1' },
      { label: 'Granchild 2' },
      { label: 'Granchild 3' }
    ]
    tree = {
      label: 'Parent',
      children: [{ label: 'Child', children: granchildren }]
    }

    plot_result = <<~TREE
      Parent
      └─ Child
         ├─ Granchild 1
         ├─ Granchild 2
         └─ Granchild 3
    TREE
    assert_equal plot_result, Plotter.plot_tree(tree)
  end

  def test_plot_multiple_children_and_granchildren
    granchildren = [
      { label: 'Granchild 1' },
      { label: 'Granchild 2' },
      { label: 'Granchild 3' }
    ]
    tree = {
      label: 'Parent',
      children: [
        { label: 'Child 1', children: granchildren },
        { label: 'Child 2', children: granchildren },
      ]
    }

    plot_result = <<~TREE
      Parent
      ├─ Child 1
      │  ├─ Granchild 1
      │  ├─ Granchild 2
      │  └─ Granchild 3
      └─ Child 2
         ├─ Granchild 1
         ├─ Granchild 2
         └─ Granchild 3
    TREE
    assert_equal plot_result, Plotter.plot_tree(tree)
  end

  def test_plot_connection_line_for_granchildren_when_last_child
    grangranchildren = [
      { label: 'Grangranchild 1' },
      { label: 'Grangranchild 2' }
    ]
    granchildren = [
      { label: 'Granchild 1', children: grangranchildren },
      { label: 'Granchild 2' },
      { label: 'Granchild 3' }
    ]
    tree = {
      label: 'Parent',
      children: [
        { label: 'Child 1', children: granchildren },
        { label: 'Child 2', children: granchildren }
      ]
    }

    plot_result = <<~TREE
      Parent
      ├─ Child 1
      │  ├─ Granchild 1
      │  │  ├─ Grangranchild 1
      │  │  └─ Grangranchild 2
      │  ├─ Granchild 2
      │  └─ Granchild 3
      └─ Child 2
         ├─ Granchild 1
         │  ├─ Grangranchild 1
         │  └─ Grangranchild 2
         ├─ Granchild 2
         └─ Granchild 3
    TREE
    assert_equal plot_result, Plotter.plot_tree(tree)
  end

  def test_plot_single_child_with_nil_granchildren
    tree = {
      label: 'Parent',
      children: [{ label: 'Child', children: nil }]
    }

    plot_result = <<~TREE
      Parent
      └─ Child
    TREE
    assert_equal plot_result, Plotter.plot_tree(tree)
  end

  def test_plot_single_child_with_no_granchildren_node
    tree = {
      label: 'Parent',
      children: [{ label: 'Child' }]
    }

    plot_result = <<~TREE
      Parent
      └─ Child
    TREE
    assert_equal plot_result, Plotter.plot_tree(tree)
  end
end
