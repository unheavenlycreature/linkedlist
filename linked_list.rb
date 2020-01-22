# frozen_string_literal: true

require_relative 'node'

# Representation of a linked list.
class LinkedList
  attr_reader :head, :size

  def initialize
    @head = nil
    @size = 0
  end

  def append(value)
    if @head.nil?
      prepend(value)
      return
    end
    @size += 1
    new_tail = Node.new(value)
    tail.next_node = new_tail
  end

  def prepend(value)
    @size += 1
    new_head = Node.new(value, @head)
    @head = new_head
  end

  def tail
    return head if head.nil?

    iter = @head
    iter = iter.next_node until iter.next_node.nil?
    iter
  end

  def at(index)
    return nil if @size - 1 < index

    iter = @head
    index.times do
      iter = iter.next_node
    end
    iter
  end

  def pop
    return nil if @head.nil?

    if @head.next_node.nil?
      @size = 0
      head = @head
      @head = nil
      return head
    end

    @size -= 1
    iter = @head

    # Point to one node before the tail.
    (@size - 1).times do
      iter = iter.next_node
    end

    to_pop = iter.next_node
    iter.next_node = nil
    to_pop
  end

  def contains?(value)
    iter = @head
    until iter.nil?
      return true if iter.value == value

      iter = iter.next_node
    end
    false
  end

  def find(value)
    index = 0
    iter = @head
    until iter.nil?
      return index if iter.value == value

      iter = iter.next_node
      index += 1
    end
    nil
  end

  def to_s
    list_str = ''
    iter = @head
    until iter.nil?
      list_str += iter.to_s + ' -> '
      iter = iter.next_node
    end
    list_str += 'nil'
    list_str
  end
end
