package com.yiTian.view.modules.fubenSel
{
   import com.ui.constants.ScrollAutoType;
   import com.ui.containers.Canvas;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.manager.LangConfig;
   
   public class ShaoDangContainer extends Canvas
   {
      
      private var round:MyTextField;
      
      private var _count:int;
      
      private var list:Array = [];
      
      public function ShaoDangContainer(wid:int, hei:int, scrollDirection:String = "RIGHT", setWidth:int = 0)
      {
         super(wid,hei,scrollDirection,setWidth);
         this.round = ComponentUtil.getTextField("",this,{"textColor":14013822});
         this.round.textColor = 14013822;
         scrollAutoType = ScrollAutoType.TO_BOTTOM;
      }
      
      public function set curSDCount(count:int) : void
      {
         this._count = count;
         this.round.size = 24;
         this.round.visible = true;
         this.round.textColor = 14013822;
         this.round.text = LangConfig.getWord("279",0) + String(count) + LangConfig.getWord("828",0);
         this.align();
      }
      
      public function set cancleSaoDang(value:Boolean) : void
      {
         if(value)
         {
            this.round.textColor = 14013822;
            this.round.text = LangConfig.getWord("279",0) + String(this._count) + LangConfig.getWord("830",0);
            this.align();
         }
      }
      
      public function set isFinished(value:Boolean) : void
      {
         if(value)
         {
            this.round.textColor = 14013822;
            this.round.text = LangConfig.getWord("829",0);
         }
      }
      
      public function addItem(data:Array, value:Boolean) : void
      {
         var item:ShaoDangItem = ShaoDangItem.getItem();
         item.init(data);
         addChildAt(item,getChildIndex(this.round));
         this.list.push(item);
         this.align();
      }
      
      override public function align() : void
      {
         var nowY:int = 0;
         nowY = 0;
         var i:int = 0;
         while(i < this.list.length)
         {
            this.list[i].y = nowY;
            nowY += this.list[i].height;
            i++;
         }
         this.round.y = nowY;
         nowY += this.round.height;
         super.align();
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         while(i < this.list.length)
         {
            removeChild(this.list[i]);
            i++;
         }
         this.round.visible = false;
         this.list = [];
      }
   }
}

