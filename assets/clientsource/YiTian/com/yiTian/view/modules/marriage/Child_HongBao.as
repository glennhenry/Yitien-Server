package com.yiTian.view.modules.marriage
{
   import com.event.TextField_h;
   import com.ui.controls.Button;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextFieldAutoSize;
   
   public class Child_HongBao extends Sprite
   {
      
      private static var colorArr:Array = ["#04ff00","#33CCFF","#de45c7"];
      
      public var hongBao_id:int;
      
      public var hongBao_costList:Array;
      
      public var hongBao_numList:Array;
      
      public var btn:Button;
      
      private var bg_back:DisplayObject;
      
      private var Menoy_text:TextField_h;
      
      private var Name_text:TextField_h;
      
      public function Child_HongBao(type:int = 0)
      {
         var grid:View_Grid = null;
         this.hongBao_id = MarriageConfig.hongBao_id;
         this.hongBao_costList = MarriageConfig.hongBao_costList;
         this.hongBao_numList = MarriageConfig.hongBao_numList;
         super();
         this.bg_back = ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":0,
            "y":0,
            "width":139,
            "height":170
         },Global.Img_Cdm);
         grid = new View_Grid(true);
         grid.set_bmp_bg(View_Grid.GRID_BIGGEST_OPEN);
         grid.set_bmp_over(true,View_Grid.GRID_BIGGEST_OVER);
         grid.set_bmp_select(View_Grid.GRID_BIGGEST_DOWN);
         var vo:Vo_item = new Vo_item();
         vo.id = this.hongBao_id;
         vo.Init_lib();
         grid.vo = vo;
         this.addChild(grid);
         grid.x = 37;
         grid.y = 35;
         this.Name_text = ComponentUtil.getTextField_h(HtmlUtil.font(this.hongBao_numList[type] + LangConfig.getWord("60211",6),"#ffffff",14),this,{
            "x":69.525,
            "y":10
         });
         this.Name_text.autoSize = TextFieldAutoSize.CENTER;
         this.Menoy_text = ComponentUtil.getTextField_h(HtmlUtil.font(this.hongBao_costList[type] + LangConfig.getWord("60212",6),colorArr[type],14),this,{
            "x":69.525,
            "y":107
         });
         this.Menoy_text.autoSize = TextFieldAutoSize.CENTER;
         this.btn = ComponentUtil.getButton(LangConfig.getWord("1044",0),"Button_Four",this,{
            "x":33.5,
            "y":135,
            "name":type.toString()
         },Global.Img_Cdm);
      }
      
      public function setVis(value:Boolean) : void
      {
         this.bg_back.visible = value;
      }
      
      public function setTf(size:int) : void
      {
         this.Menoy_text.size = 12;
         this.Name_text.size = 12;
      }
   }
}

