package com.yiTian.view.modules.XianGou
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.net.message.cg.XianGouCGMessage;
   import com.yiTian.utils.ComboTweenStep;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class View_XianGou_listItem2 extends Sprite
   {
      
      private var _id:int;
      
      private var kuncun_spr:Sprite;
      
      private var _kucun:MyTextField;
      
      private var _yuanjia:MyTextField;
      
      private var _heishijia:MyTextField;
      
      private var _xiangou:MyTextField;
      
      private var shape:Shape;
      
      private var v_grid0:View_Grid;
      
      private var v_grid1:View_Grid;
      
      private var v_grid2:View_Grid;
      
      private var flyArr:Array;
      
      private var buyButton:Button;
      
      public function View_XianGou_listItem2()
      {
         super();
         this.Init();
      }
      
      private function Init() : void
      {
         ComponentUtil.getBitmap("Back_Card",this,{
            "x":0,
            "y":0
         },Global.BagBuy_Imgsdm);
         var i:int = 0;
         while(i < 3)
         {
            this["v_grid" + i] = new View_Grid();
            View_Grid(this["v_grid" + i]).set_bmp_bg();
            View_Grid(this["v_grid" + i]).set_tf_count();
            View_Grid(this["v_grid" + i]).set_bmp_over();
            this.addChild(this["v_grid" + i]);
            this["v_grid" + i].x = 16 + 45 * i;
            this["v_grid" + i].y = 29;
            i++;
         }
         this.kuncun_spr = new Sprite();
         this.addChild(this.kuncun_spr);
         this.kuncun_spr.visible = false;
         ComponentUtil.getTextField("剩余库存：",this.kuncun_spr,{
            "x":10,
            "y":5,
            "color":11523767,
            "size":12,
            "leading":0
         });
         this._yuanjia = ComponentUtil.getTextField("原价：0000元宝",this,{
            "x":158,
            "y":15,
            "color":13103823,
            "size":12,
            "leading":0
         });
         this._heishijia = ComponentUtil.getTextField("现价：0000元宝",this,{
            "x":158,
            "y":40,
            "color":4451617,
            "size":12,
            "leading":0
         });
         this._xiangou = ComponentUtil.getTextField("限购：0个",this,{
            "x":10,
            "y":77,
            "color":13424242,
            "size":12,
            "leading":0
         });
         this._kucun = ComponentUtil.getTextField("000个",this,{
            "x":72,
            "y":5,
            "color":16767782,
            "size":12,
            "leading":0
         });
         this.buyButton = ComponentUtil.getButton("立即抢购","Button_Buy",this,{
            "x":181,
            "y":74,
            "textColor":16184781
         },Global.BagBuy_Imgsdm);
         this.buyButton.callBack = this.buy;
         this.shape = new Shape();
         this.addChild(this.shape);
      }
      
      private function buy(e:MouseEvent) : void
      {
         XianGouCGMessage.CG_BUY(this._id);
      }
      
      public function set id(num:int) : void
      {
         this._id = num;
      }
      
      public function get id() : int
      {
         return this._id;
      }
      
      public function set item(arr:Array) : void
      {
         var item:Vo_item = null;
         trace("****set item");
         this.flyArr = [];
         var i:int = 0;
         while(i < 3)
         {
            if(arr[i][0] == 0)
            {
               this["v_grid" + i].visible = false;
            }
            else
            {
               this["v_grid" + i].visible = true;
               item = new Vo_item();
               item.id = arr[i][0];
               item.count = arr[i][1];
               item.Init_lib();
               View_Grid(this["v_grid" + i]).vo = item;
               this.flyArr.push(this["v_grid" + i]);
            }
            i++;
         }
      }
      
      public function set yuanjia(num:int) : void
      {
         this._yuanjia.text = "原价：" + num + "元宝";
         this.shape.graphics.clear();
         this.shape.graphics.lineStyle(1,16777215,1);
         this.shape.graphics.moveTo(this._yuanjia.x,this._yuanjia.y + this._yuanjia.height / 2);
         this.shape.graphics.lineTo(this._yuanjia.x + this._yuanjia.width,this._yuanjia.y + this._yuanjia.height / 2);
      }
      
      public function set heishijia(num:int) : void
      {
         this._heishijia.text = "现价：" + num + "元宝";
      }
      
      public function set xiangou(num:int) : void
      {
         if(num == 0)
         {
            this._xiangou.text = "限购:" + num + "个";
         }
         else if(num > 0)
         {
            this._xiangou.text = "限购:" + num + "个";
         }
         else
         {
            this._xiangou.text = "";
         }
      }
      
      public function set kucun(num:int) : void
      {
         if(num == 0)
         {
            this.kuncun_spr.visible = true;
            this._kucun.text = num + "个";
         }
         else if(num > 0)
         {
            this.kuncun_spr.visible = true;
            this._kucun.text = num + "个";
         }
         else
         {
            this.kuncun_spr.visible = false;
         }
      }
      
      public function FlyToBag() : void
      {
         var i:* = undefined;
         trace("****flyArr",this.flyArr.length);
         for(i in this.flyArr)
         {
            ComboTweenStep.toBag(this.flyArr[i]);
         }
      }
   }
}

