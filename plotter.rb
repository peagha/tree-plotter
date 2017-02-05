require_relative 'enumerable_refinements'

module Plotter
  using EnumerableRefinements

  module_function

  def plot_tree(item)
    tree = plot_item(item.label)
    plot_children(item, tree)
    tree
  end

  def plot_children(item, tree, level = 0, parent_last = false)
    indentation_base = parent_last ? '   ' : '│  '
    indentation = indentation_base * level

    item.children.each_flag_last do |child, last|
      bullet = last ? '└─ ' : '├─ '
      tree << plot_item(child.label, bullet, indentation)

      plot_children(child, tree, level + 1, last)
    end
  end

  def plot_item(label, bullet = nil, indentation = nil)
    "#{indentation}#{bullet}#{label}\n"
  end
end
