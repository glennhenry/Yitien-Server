package com.yiTian.view.modules.yellowDiamond
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_SPStr;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.net.message.cg.YelloDiaCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class OnLineItem extends Sprite
   {
      
      private static var LEN:int = 2;
      
      private var tf:MyTextField;
      
      private var btn:Button;
      
      private var gridVec:Vector.<View_Grid> = new Vector.<View_Grid>();
      
      public function OnLineItem()
      {
         super();
      }
      
      public function init() : void
      {
         var grid:View_Grid = null;
         var vo:Vo_item = null;
         this.tf = ComponentUtil.getTextField("",this,{
            "x":27,
            "y":13,
            "color":14918424
         });
         this.btn = ComponentUtil.getButton(LangConfig.getWord("60350",6),"Button_Orange",this,{
            "x":330,
            "y":10,
            "textColor":16184781
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
            "x":12,
            "y":44,
            "width":452,
            "height":2
         },Global.Img_Cdm);
         if(Global.pf == Enum_SPStr.QQGAME)
         {
            LEN = 3;
         }
         var i:int = 0;
         while(i < LEN)
         {
            grid = new View_Grid();
            grid.set_bmp_bg();
            grid.set_bmp_over(true,null);
            grid.set_tf_count(true,false,true);
            vo = new Vo_item();
            vo.id = i == 0 ? 46201 : 46061;
            if(i == 2)
            {
               vo.id = 46589;
            }
            vo.Init_lib();
            addChild(grid);
            grid.x = 117 + 50 * i;
            grid.y = 4;
            grid.vo = vo;
            this.gridVec.push(grid);
            i++;
         }
         this.btn.addEventListener(MouseEvent.CLICK,this.link);
      }
      
      public function setGridCount(_num:int) : void
      {
         this.gridVec[0].count = _num;
         this.gridVec[1].count = _num;
         if(Global.pf == Enum_SPStr.QQGAME)
         {
            this.gridVec[2].count = 1;
         }
      }
      
      private function link(e:MouseEvent) : void
      {
         if(View_qqOnLine.awardType == 1)
         {
            YelloDiaCGMessage.CG_GET_QQGIFT();
         }
         else if(View_qqOnLine.awardType == 2)
         {
            YelloDiaCGMessage.CG_GET_AIWAN_GIFT();
         }
         else if(View_qqOnLine.awardType == 3)
         {
            YelloDiaCGMessage.CG_GET_CHITU_GIFT();
         }
      }
      
      public function set data(obj:Object) : void
      {
         if(obj.day < 3)
         {
            this.tf.text = LangConfig.getWord("60364",6) + obj.day + LangConfig.getWord("60365",6);
         }
         else
         {
            this.tf.text = LangConfig.getWord("60364",6) + obj.day + LangConfig.getWord("60366",6);
         }
         switch(obj.status)
         {
            case 1:
               this.btn.enabled = true;
               this.btn.mouseEnabled = true;
               this.btn.label = LangConfig.getWord("60350",6);
               break;
            case 0:
               this.btn.enabled = false;
               this.btn.mouseEnabled = false;
               this.btn.label = LangConfig.getWord("60367",6);
               break;
            case 2:
               this.btn.enabled = false;
               this.btn.mouseEnabled = false;
               this.btn.label = HtmlUtil.font(LangConfig.getWord("60351",6),"#04ff00");
         }
      }
      
      public function getGoods() : void
      {
         var i:int = 0;
         while(i < this.gridVec.length)
         {
            Tween.gridToBagBezierFuncDef(this.gridVec[i]);
            i++;
         }
         this.btn.enabled = false;
         this.btn.label = HtmlUtil.font(LangConfig.getWord("60351",6),"#04ff00");
      }
   }
}

