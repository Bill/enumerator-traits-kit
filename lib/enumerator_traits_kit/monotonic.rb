# see also Enumerator#declare_trait, ensure_trait

module EnumeratorTraitsKit

  # The intersection operator (&) requires both self and the other sequence
  # to be monotonically increasing and to agree on the direction: either
  # both are monotonically increasing, or both are monotonically decreasing.
  # If they disagree, then intersection will raise this exception.
  class MonotonicityConflict < Exception;end


  module Monotonic
    def self.ensure_with; EnsureMonotonic; end

    def direction; nil; end
  end

  module MonotonicIncreasing # < Monotonic
    include Monotonic

    def self.ensure_with; EnsureMonotonicIncreasing; end

    def direction; MonotonicIncreasing; end
  end

  module MonotonicDecreasing # < Monotonic
    include Monotonic

    def self.ensure_with; EnsureMonotonicDecreasing; end

    def direction; MonotonicDecreasing; end
  end

  class NonMonotonic < Exception;end
  class NonMonotonicIncreasing < Exception;end
  class NonMonotonicDecreasing < Exception;end

  # A mixin for an enumerator instance. This enumerator passes through the value stream
  # from the other enumerator while determining the "direction" of the values
  # i.e. monotonically increasing (1) or monotonically decreasing (-1) and throws
  # an exception if the direction changes.
  # Call like: some_enumerator.extend(Enumerator::Monotonic)
  module EnsureMonotonic # < Monotonic
    include Monotonic

    def next
      super.tap do |val|
        if defined?(@previous)
          case val <=> @previous
          when  1 then new_direction = MonotonicIncreasing
          # when  0 @direction remains undefined
          when -1 then new_direction = MonotonicDecreasing
          end
          if defined?(@direction) && defined?(new_direction)
            raise NonMonotonic,
              "direction changed from #{@direction} to #{new_direction} with value #{val}" \
              if new_direction != @direction
          end
          if defined?(new_direction)
            @direction = new_direction
          end
        end
        @previous = val
      end
    end

    # nil for unknown/undefined, otherwise 1 or -1
    def direction
      @direction
    end
  end

  module EnsureMonotonicIncreasing
    include EnsureMonotonic

    def next
      super.tap do |val|
        raise NonMonotonicIncreasing, "at value #{val}" \
          unless direction == MonotonicIncreasing
      end
    end
  end

  module EnsureMonotonicDecreasing
    include EnsureMonotonic

    def next
      super.tap do |val|
        raise NonMonotonicDecreasing, "at value #{val}" \
          unless direction == MonotonicDecreasing
      end
    end
  end

end
