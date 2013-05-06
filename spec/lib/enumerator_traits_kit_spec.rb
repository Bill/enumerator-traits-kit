require 'spec_helper'
require 'enumerator_comparable'

describe EnumeratorTraitsKit do

  def seq(s)
    s.each_char
  end
  def seq_up(s)
    seq(s).declare_trait(EnumeratorTraitsKit::MonotonicIncreasing)
  end

  describe 'intersection' do
    describe 'empty inputs' do
      let(:a){seq_up('')}
      let(:b){seq_up('')}
      it 'should produce empty intersection' do
        (a & b).should == seq_up('')
      end
    end
    describe 'left empty input' do
      let(:a){seq_up('')}
      let(:b){seq_up('a')}
      it 'should produce empty intersection' do
        (a & b).should == seq_up('')
      end
    end
    describe 'right empty input' do
      let(:a){seq_up('a')}
      let(:b){seq_up('')}
      it 'should produce empty intersection' do
        (a & b).should == seq_up('')
      end
    end
    describe 'non-empty non-intersecting inputs' do
      let(:a){seq_up('ab')}
      let(:b){seq_up('cd')}
      it 'should produce empty intersection' do
        (a & b).should == seq_up('')
      end
    end
    describe 'identical single' do
      let(:a){seq_up('a')}
      let(:b){seq_up('a')}
      it 'should produce "a"' do
        (a & b).should == seq_up('a')
      end
    end
    describe 'identical double' do
      let(:a){seq_up('ab')}
      let(:b){seq_up('ab')}
      it 'should produce "ab"' do
        (a & b).should == seq_up("ab")
      end
    end
    describe 'intersecting double' do
      let(:a){seq_up('ab')}
      let(:b){seq_up('bc')}
      it 'should produce "b"' do
        (a & b).should == seq_up('b')
      end
    end
    describe 'intersecting double' do
      let(:a){seq_up('ab')}
      let(:b){seq_up('bc')}
      it 'should produce "b"' do
        (a & b).should == seq_up('b')
      end
    end
    describe 'repeats' do
      let(:a){seq_up('abb')}
      let(:b){seq_up('aab')}
      it 'should produce "ab"' do
        (a & b).should == seq_up('ab')
      end
    end
  end

end
