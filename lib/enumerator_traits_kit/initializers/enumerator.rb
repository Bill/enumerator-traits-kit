class Enumerator

  # Returns a sequence that is the intersection of two sequences.
  # Assumes this sequence (and the other):
  #  1. both produce comparable and orderable objects
  #  2. both sequences are monotonically increasing or monotonically decreasing
  def &(other)
    # we have to be monotonic and we have to already know our direction
    # and we have to agree on our direction
    ensure_trait(EnumeratorTraitsKit::Monotonic)
    other.ensure_trait(EnumeratorTraitsKit::Monotonic)
    raise EnumeratorTraitsKit::MonotonicityConflict \
      if self.direction.nil? || self.direction != other.direction
    direction = self.direction

    # TODO: make this lazy!
    Enumerator.new do |yielder|
      # Look at front of both sequences
      # allow StopIteration to be raised if either is at end
      mine   = self.next
      theirs = other.next
      loop do
        case mine <=> theirs
        when  0
          yielder << mine
          mine   = self.next
          theirs = other.next
        when -1
          if direction == EnumeratorTraitsKit::MonotonicIncreasing
            mine = self.next while mine < theirs
          else # direction == MonotonicDecreasing
            theirs = other.next while theirs < mine
          end
        when  1
          if direction == EnumeratorTraitsKit::MonotonicIncreasing
            theirs = other.next while theirs < mine
          else # direction == MonotonicDecreasing
            mine = self.next while mine < theirs
          end
        end # case
      end # loop
    end.declare_trait(direction) # we have same direction as our inputs
  end

end
