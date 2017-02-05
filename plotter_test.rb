# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'plotter'

class PlotterTest < Minitest::Test
  def test_plot_single_item
    item = { label: 'Item label' }

    assert_equal "Item label\n", Plotter.plot_tree(item)
  end

  def test_plot_single_child
    tree = {
      label: 'Parent label',
      children: [{ label: 'Child label' }]
    }

    plot_result = <<~TREE
      Parent label
      └─ Child label
    TREE
    assert_equal plot_result, Plotter.plot_tree(tree)
  end

  def test_plot_multiple_children
    tree = {
      label: 'Parent label',
      children: [
        { label: 'Child label 1' },
        { label: 'Child label 2' },
        { label: 'Child label 3' }
      ]
    }

    plot_result = <<~TREE
      Parent label
      ├─ Child label 1
      ├─ Child label 2
      └─ Child label 3
    TREE
    assert_equal plot_result, Plotter.plot_tree(tree)
  end

  def test_plot_granchild
    granchild = { label: 'Granchild label' }
    tree = {
      label: 'Parent label',
      children: [{ label: 'Child label', children: [granchild] }]
    }

    plot_result = <<~TREE
      Parent label
      └─ Child label
         └─ Granchild label
    TREE
    assert_equal plot_result, Plotter.plot_tree(tree)
  end

  def test_plot_multiple_granchildren
    granchildren = [
      { label: 'Granchild label 1' },
      { label: 'Granchild label 2' },
      { label: 'Granchild label 3' }
    ]
    tree = {
      label: 'Parent label',
      children: [{ label: 'Child label', children: granchildren }]
    }

    plot_result = <<~TREE
      Parent label
      └─ Child label
         ├─ Granchild label 1
         ├─ Granchild label 2
         └─ Granchild label 3
    TREE
    assert_equal plot_result, Plotter.plot_tree(tree)
  end

  def test_plot_multiple_children_and_granchildren
    granchildren = [
      { label: 'Granchild label 1' },
      { label: 'Granchild label 2' },
      { label: 'Granchild label 3' }
    ]
    tree = {
      label: 'Parent label',
      children: [
        { label: 'Child label 1', children: granchildren },
        { label: 'Child label 2', children: granchildren },
      ]
    }

    plot_result = <<~TREE
      Parent label
      ├─ Child label 1
      │  ├─ Granchild label 1
      │  ├─ Granchild label 2
      │  └─ Granchild label 3
      └─ Child label 2
         ├─ Granchild label 1
         ├─ Granchild label 2
         └─ Granchild label 3
    TREE
    assert_equal plot_result, Plotter.plot_tree(tree)
  end

  def test_plot_connection_line_for_granchildren_when_last_child
    grangranchildren = [
      { label: 'Grangranchild label 1' },
      { label: 'Grangranchild label 2' }
    ]
    granchildren = [
      { label: 'Granchild label 1', children: grangranchildren },
      { label: 'Granchild label 2' },
      { label: 'Granchild label 3' }
    ]
    tree = {
      label: 'Parent label',
      children: [
        { label: 'Child label 1', children: granchildren },
        { label: 'Child label 2', children: granchildren }
      ]
    }

    plot_result = <<~TREE
      Parent label
      ├─ Child label 1
      │  ├─ Granchild label 1
      │  │  ├─ Grangranchild label 1
      │  │  └─ Grangranchild label 2
      │  ├─ Granchild label 2
      │  └─ Granchild label 3
      └─ Child label 2
         ├─ Granchild label 1
         │  ├─ Grangranchild label 1
         │  └─ Grangranchild label 2
         ├─ Granchild label 2
         └─ Granchild label 3
    TREE
    assert_equal plot_result, Plotter.plot_tree(tree)
  end

  def test_plot_single_child_with_nil_granchildren
    tree = {
      label: 'Parent label',
      children: [{ label: 'Child label', children: nil }]
    }

    plot_result = <<~TREE
      Parent label
      └─ Child label
    TREE
    assert_equal plot_result, Plotter.plot_tree(tree)
  end

  def test_plot_single_child_with_no_granchildren_node
    tree = {
      label: 'Parent label',
      children: [{ label: 'Child label' }]
    }

    plot_result = <<~TREE
      Parent label
      └─ Child label
    TREE
    assert_equal plot_result, Plotter.plot_tree(tree)
  end
end
