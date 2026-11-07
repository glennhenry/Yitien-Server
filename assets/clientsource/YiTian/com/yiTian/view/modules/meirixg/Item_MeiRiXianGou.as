package com.yiTian.view.modules.meirixg
{
   import com.ui.controls.Button;
   import com.ui.controls.CheckBox;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Enum_type_grid;
   import com.yiTian.data.model.Model_shop;
   import com.yiTian.data.vo.Vo_MeiRiXianGou;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.MeiRiXianGouCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Bezier;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextFormatAlign;
   import flashx.textLayout.formats.TextAlign;
   
   public class Item_MeiRiXianGou extends Sprite
   {
      
      private var price_YJ:MyTextField;
      
      private var price_XJ:MyTextField;
      
      private var count_txt:MyTextField;
      
      private var grid:View_Grid;
      
      private var name_txt:MyTextField;
      
      private var _id:int;
      
      private var __vo:Vo_MeiRiXianGou;
      
      private var tempVo:Vo_item;
      
      private var eff:Effect;
      
      private var bm_moneyX:Sprite;
      
      private var bm_money:Sprite;
      
      private var bm_hot:Sprite;
      
      private var buy_btn:Button;
      
      private var isFirst:Boolean = true;
      
      public function Item_MeiRiXianGou()
      {
         super();
         this.initUI();
      }
      
      private function initUI() : void
      {
         ComponentUtil.getBitmap("Back_WPDK",this,{
            "x":0,
            "y":0
         },Global.XSFQdm);
         this.grid = new View_Grid(true);
         this.grid.type = Enum_type_grid.NO_DRAG;
         this.grid.set_bmp_bg(View_Grid.GRID_BIGGEST_OPEN);
         this.grid.set_bmp_over(true,View_Grid.GRID_BIGGEST_OVER);
         this.grid.set_bmp_select(View_Grid.GRID_BIGGEST_DOWN);
         this.grid.x = 16;
         this.grid.y = 31;
         this.addChild(this.grid);
         this.bm_hot = new Sprite();
         this.addChild(this.bm_hot);
         this.bm_money = new Sprite();
         this.addChild(this.bm_money);
         this.bm_moneyX = new Sprite();
         this.addChild(this.bm_moneyX);
         this.name_txt = ComponentUtil.getTextField("礼包中文名称",this,{
            "x":125,
            "y":1,
            "color":16742144,
            "size":12,
            "leading":0
         },TextAlign.CENTER);
         ComponentUtil.getTextField("原价：",this,{
            "x":96,
            "y":32,
            "color":14404503,
            "size":12,
            "leading":0
         });
         this.price_YJ = ComponentUtil.getTextField("原价：2080元宝",this,{
            "x":156,
            "y":32,
            "color":14404503,
            "size":12,
            "leading":0
         },TextAlign.CENTER);
         ComponentUtil.getTextField("售价：",this,{
            "x":96,
            "y":50,
            "color":16764206,
            "size":12,
            "leading":0
         });
         this.price_XJ = ComponentUtil.getTextField("售价：1888元宝",this,{
            "x":156,
            "y":50,
            "color":16764206,
            "size":12,
            "leading":0
         },TextAlign.CENTER);
         ComponentUtil.getTextField("每日限购：",this,{
            "x":96,
            "y":78,
            "color":14404503,
            "size":12,
            "leading":0
         });
         this.buy_btn = ComponentUtil.getButton("购买","Button_Buy",this,{
            "x":192,
            "y":71,
            "textColor":16771436,
            "callBack":this.onBuy
         },Global.XSFQdm);
         this.count_txt = ComponentUtil.getTextField("0/1",this,{
            "x":156,
            "y":78,
            "color":16764206,
            "size":12,
            "leading":0
         });
         ComponentUtil.getBitmap("Line_YuanJia",this,{
            "x":131,
            "y":36
         },Global.XSFQdm);
      }
      
      private function onBuy(e:MouseEvent) : void
      {
         var moneyName:String;
         var str:String;
         var ck:Function = null;
         var end:Function = null;
         ck = function(box:CheckBox):void
         {
            View_MeiRiXianGou.dic[vo.index] = box.selected;
         };
         end = function():void
         {
            View_MeiRiXianGou.tempIndex = _id;
            MeiRiXianGouCGMessage.CG_MRXG_BUY(_id);
         };
         if(Boolean(View_MeiRiXianGou.dic[this.vo.index]))
         {
            end();
            return;
         }
         moneyName = Enum_MeiRiXianGou.moneyName[this.vo.moneyType];
         str = "<font color=\'#ffffff\'>是否花费</font><font color=\'#f9ff00\'>" + this.vo.priceXJ + "</font><font color=\'#ffffff\'>" + moneyName + "购买" + HtmlUtil.font(this.grid.vo.str_name,Model_shop.get_color_arr[this.tempVo.color - 1]) + "?</font>";
         View_Alert.show(str,View_Alert.OK_CANCAL,end,null,null,null,350,"","",TextFormatAlign.LEFT,true);
         View_Alert.instance.showCheckBox = ck;
      }
      
      public function iconFLY() : void
      {
         var bm:Bitmap = null;
         var p:Point = null;
         var totalTime:int = 0;
         var dir:String = "resource/image/icon/" + this.grid.vo.str_icon + ".png";
         bm = new Bitmap();
         bm.bitmapData = this.grid.bmp_icon.bitmapData;
         p = this.grid.localToGlobal(new Point(0,0));
         bm.x = p.x;
         bm.y = p.y;
         var aimPoint:Point = UIManager.mainMenu.getItemGlobalPosC("bagBtn");
         if(totalTime <= 0)
         {
            totalTime = Math.pow(Math.pow(aimPoint.y - p.y,2) + Math.pow(aimPoint.x - p.x,2),0.5) * 3.5;
         }
         var py:Number = p.y + Math.abs(p.y - aimPoint.y) / 5;
         var point1:Point = new Point(aimPoint.x,py);
         Bezier.getInstance().addTarget(bm,aimPoint,totalTime,GameScene.popupLayer,-1,[point1],Tween.CFUN);
      }
      
      public function set vo(_vo:Vo_MeiRiXianGou) : void
      {
         var vo_item:Vo_item = null;
         this.__vo = _vo;
         if(this.isFirst)
         {
            if(Boolean(this.vo.hot))
            {
               ComponentUtil.getBitmap(Enum_MeiRiXianGou.getHot(this.vo.hot),this.bm_hot,{
                  "x":42,
                  "y":20
               },Global.XSFQdm);
            }
            ComponentUtil.getBitmap(Enum_MeiRiXianGou.getMoneyIcon(this.vo.moneyType),this.bm_money,{
               "x":192,
               "y":35
            },Global.XSFQdm);
            ComponentUtil.getBitmap(Enum_MeiRiXianGou.getMoneyIcon(this.vo.moneyType),this.bm_moneyX,{
               "x":192,
               "y":53
            },Global.XSFQdm);
            this.isFirst = false;
         }
         var moneyName:String = Enum_MeiRiXianGou.moneyName[this.vo.moneyType];
         this.price_YJ.text = "" + _vo.priceYJ;
         this.price_XJ.text = "" + _vo.priceXJ;
         this.count_txt.text = this.__vo.count + "/" + this.__vo.countMAX;
         this._id = _vo.index;
         vo_item = new Vo_item();
         vo_item.id = _vo.popId;
         vo_item.bBind = true;
         vo_item.Init_lib();
         this.grid.vo = vo_item;
         this.tempVo = vo_item;
         var b:Boolean = _vo.count < _vo.countMAX;
         this.buy_btn.mouseEnabled = this.buy_btn.enabled = b;
         this.name_txt.htmlText = HtmlUtil.font(vo_item.str_name,Model_shop.get_color_arr[vo_item.color - 1]);
         if(!this.eff && Boolean(_vo.hightLine))
         {
            this.eff = EffectManager.addEffect("35180",this.grid,1000,32,32,true);
         }
      }
      
      public function get vo() : Vo_MeiRiXianGou
      {
         return this.__vo;
      }
   }
}

