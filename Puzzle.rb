class Puzzle
  attr_accessor :answers,:questions,:total_cnt,:side_cnt,:moves,:empty_no,:difficult
  
  def initialize(in_num=9)
    @side_cnt=Math::sqrt(in_num).truncate
    @total_cnt=@side_cnt*@side_cnt
    @answers=Array.new
    @questions=Array.new
    @moves=Array.new
    @@shuffle_cnt = 0
    @empty_no=@total_cnt
    @difficult=:Normal
    generate_answer()  
    @questions=Marshal.load(Marshal.dump(@answers))
  end
  def set_shuffle_cnt()
    case @difficult
    when :Easy
      @@shuffle_cnt = @total_cnt * 3
    when :Normal
      @@shuffle_cnt = @total_cnt * 6
    when :Hard
      @@shuffle_cnt = @total_cnt *10
    end
  end
  def generate_answer()
    @answers=[*0..@total_cnt].to_a
  end
  def generate_question()
    set_shuffle_cnt()
    @@shuffle_cnt.times do
        random_move()
    end
    if (chk_completion) then
       random_move()
    end
  end
  def chk_completion()
    if (@answers == @questions) then
      @moves=Array.new
      return true
    else
      return false
    end
  end 
  def set_move()
    #動かせるセルを特定する
    @moves[1]=@empty_no-1         #空白から右のセル
    @moves[2]=@empty_no+1         #空白から左のセル
    @moves[3]=@empty_no+@side_cnt #空白から下のセル
    @moves[4]=@empty_no-@side_cnt #空白から上のセル
    tmp=@empty_no % @side_cnt
    #枠外にはみ出たものはゼロにする
    @moves[4]=0 if (@moves[4]<0)
    @moves[3]=0 if (@moves[3]>@total_cnt)
    @moves[2]=0 if (tmp==0)
    @moves[1]=0 if (tmp==1)
  end
  def random_move()
    set_move()
    while(true)
      tmp=(rand(4)+1).truncate #動かすセル1-4をランダムにひとつ選ぶ
      if(@moves[tmp]!=0) then
        swap=@questions[@moves[tmp]]
        @questions[@moves[tmp]]=@questions[@empty_no]
        @questions[@empty_no]=swap
        @empty_no=@moves[tmp]
        return
      end
    end
  end
  def move(in_move_no)
    return if(chk_completion())
   if(in_move_no.to_i >=1 and in_move_no.to_i <=@total_cnt) then
      set_move()
      (1..4).each {|i| #４つの動かせるセルのどれかを選択されたか？
        if @moves[i]==in_move_no.to_i then
          swap=@questions[in_move_no.to_i]
          @questions[in_move_no.to_i]=@questions[@empty_no]
          @questions[@empty_no]=swap
          @empty_no=in_move_no.to_i
        end
      }
    end
  end
  private :random_move ,:set_shuffle_cnt
end
  
  

