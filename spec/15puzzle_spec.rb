# -*- coding: utf-8 -*-
require '../Puzzle.rb'
describe Puzzle do
  before :each do
    @puzzle = Puzzle.new 9
  end
  it '10この配列ができること' do
    @puzzle.generate_answer()
    @puzzle.answers.should have(10).items
  end
  it 'question配列とansers配列が一致しない' do
    @puzzle.generate_answer()
    @puzzle.generate_question()
    @puzzle.answers.should_not == @puzzle.questions
  end
end
