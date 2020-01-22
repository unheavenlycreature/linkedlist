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
    return @head if @head.nil?

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
    remove_at(@size - 1)
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

  # Inserts a node at the given index. If the list
  # is shorter than that index, nodes with nil values
  # are created.
  def insert_at(value, index)
    return prepend(value) if index.zero?

    # If the list is empty we need to initialize the head.
    if @head.nil?
      @head = Node.new
      iter = @head
      @size += 1
    end

    iter = @head

    # Move to one position behind the index we'd like to
    # insert at.
    (index - 1).times do
      if iter.next_node.nil?
        iter.next_node = Node.new
        iter = iter.next_node
        @size += 1
      else
        iter = iter.next_node
      end
    end
    @size += 1
    to_insert = Node.new(value, iter.next_node)
    iter.next_node = to_insert
  end

  def remove_at(index)
    return nil if index > @size - 1

    @size -= 1
    if index == 0
      to_return = @head
      @head = @head.next_node
      return to_return
    end

    iter = @head
    (index - 1).times do
      iter = iter.next_node
    end

    to_return = iter.next_node
    iter.next_node = to_return.next_node
    to_return.next_node = nil
    to_return
  end
end
