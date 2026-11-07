package com.yiTian.view.modules.nationalTreasure
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_equip;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.net.message.cg.NationalTreasureCGMessage;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class Child_IntegrationShopItem extends Sprite
   {
      
      private var textName:MyTextField;
      
      private var textPrice:MyTextField;
      
      private var btn:Button;
      
      public var grid:View_Grid;
      
      private var gridId:int;
      
      public function Child_IntegrationShopItem()
      {
         super();
         ComponentUtil.getScaleBitmap("Back_WYBianQiang",[3,3,1,1],this,{
            "x":0,
            "y":0,
            "width":161,
            "height":55
         },Global.JFDHdm);
         this.btn = ComponentUtil.getButton("兑换","Button_Two",this,{
            "x":108,
            "y":15,
            "textColor":16771436
         },Global.Img_Cdm);
         this.textPrice = ComponentUtil.getTextField("5000积分",this,{
            "x":47,
            "y":17,
            "color":16184781,
            "size":12,
            "leading":0
         });
         this.grid = new View_Grid();
         this.grid.set_bmp_bg();
         this.grid.set_bmp_over();
         this.grid.set_bmp_select();
         this.grid.set_tf_count(true,false,true);
         this.grid.x = 7;
         this.grid.y = 7;
         addChild(this.grid);
         this.btn.addEventListener(MouseEvent.CLICK,this.onClick);
      }
      
      public function setVo(voStr:String, score:int, index:int) : void
      {
         var _voI:Vo_item = null;
         var _voE:Vo_equip = null;
         if(!voStr)
         {
            this.grid.vo = null;
            return;
         }
         var arr:Array = voStr.split("_");
         if(!arr || !arr.length)
         {
            this.grid.vo = null;
            return;
         }
         this.gridId = index;
         var _type:int = int(arr[0]);
         var _id:int = int(arr[1]);
         var _count:int = int(arr[2]);
         if(_type == Enum_NationalTreasure.ITEM)
         {
            _voI = new Vo_item();
            _voI.id = _id;
            _voI.Init_lib();
            _voI.count = _count;
            this.grid.vo = _voI;
         }
         else if(_type == Enum_NationalTreasure.EQUIP)
         {
            _voE = new Vo_equip();
            _voE.id = _id;
            _voE.Init_lib();
            _voE.count = _count;
            this.grid.vo = _voE;
         }
         this.textPrice.text = score + "积分";
      }
      
      private function onClick(e:MouseEvent) : void
      {
         NationalTreasureCGMessage.CG_BUY_GOOD(this.gridId);
      }
   }
}

