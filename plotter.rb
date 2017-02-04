# frozen_string_literal: true

require_relative 'enumerable_refinements'

module Plotter
  using EnumerableRefinements

  module_function

  def plot_tree(item)
    str = String.new
    str << plot_item(item.label)

    plot_children(item, str)

    str
  end

  def plot_children(item, str, lvl = 0, indentation_string = '│  ')
    item.children.each_flag_last do |child, last|
      bullet = last ? '└─ ' : '├─ '

      indentation = indentation_string * lvl

      str << plot_item(child.label, bullet, indentation)

      indentation_string = '   ' if lvl.zero? && last
      plot_children(child, str, lvl + 1, indentation_string)
    end
  end

  def plot_item(label, bullet = nil, indentation = nil)
    "#{indentation}#{bullet}#{label}\n"
  end
end
