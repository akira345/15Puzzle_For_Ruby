class Puzzle
  attr_accessor :gamen,:souwaku,:waku,:kouho,:status,:empty_no,:mode
  def initialize(in_num=9)
    @waku=Math::sqrt(in_num).truncate
    @souwaku=@waku*@waku
    @gamen=Array.new
    @kouho=Array.new
    for i in 0..@souwaku
      @gamen[i]=i
    end 
    @status=0
    @empty_no=@souwaku  
  end
  def chk_complate()
    @gamen.each_with_index{|val,key|
      return false if(val!=key) 
    }
    return true
  end 
  def set_move()
    if @status==0 then
      @kouho = Array.new
      return
    end
    @kouho[1]=@empty_no-1
    @kouho[2]=@empty_no+1
    @kouho[3]=@empty_no+@waku
    @kouho[4]=@empty_no-@waku
    tmp=@empty_no % @waku
    @kouho[4]=0 if (@kouho[4]<0)
    @kouho[3]=0 if (@kouho[3]>@souwaku)
    @kouho[2]=0 if (tmp==0)
    @kouho[1]=0 if (tmp==1)
  end
  def random_move()
    set_move()
    while(true)
      tmp=(rand(4)+1).truncate
      if(@kouho[tmp]!=0) then
        swap=@gamen[@kouho[tmp]]
        @gamen[@kouho[tmp]]=@gamen[@empty_no]
        @gamen[@empty_no]=swap
        @empty_no=@kouho[tmp]
        return
      end
    end
  end
  def move(move_no)
    return if(@status!=3)
    if(move_no!="" and move_no!=0)then
      for i in [1..4]
        if @kouho[i]==move_no then
          swap=@gamen[move_no]
          @gamen[move_no]=@gamen[@empty_no]
          @gamen[@empty_no]=swap
          @empty_no=move_no
        end
      end
    end
  end

end
  
  

