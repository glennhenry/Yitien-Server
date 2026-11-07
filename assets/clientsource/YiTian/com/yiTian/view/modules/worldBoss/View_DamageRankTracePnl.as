package com.yiTian.view.modules.worldBoss
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class View_DamageRankTracePnl extends Panel
   {
      
      private static var _instance:View_DamageRankTracePnl;
      
      private var _mainLayer:Sprite;
      
      private var _btnShow:Button;
      
      private var _btnHide:Button;
      
      private var _btnIntroduce:Button;
      
      private var _tfMyRank:MyTextField;
      
      private var _tfMyDamage:MyTextField;
      
      private var _items:Array = [];
      
      public function View_DamageRankTracePnl()
      {
         super();
         bAutoRemove = false;
         init();
      }
      
      public static function get instance() : View_DamageRankTracePnl
      {
         return _instance = _instance || new View_DamageRankTracePnl();
      }
      
      override protected function initStaticView() : void
      {
         var y1:Number = NaN;
         var yInc:Number = NaN;
         var i:int = 0;
         var item:Child_FightInfItem = null;
         this._mainLayer = new Sprite();
         addChild(this._mainLayer);
         ComponentUtil.getScaleBitmap("Back_HuoDong",[60,36,3,5],this._mainLayer,{
            "x":0,
            "y":0,
            "width":320,
            "height":230
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this._mainLayer,{
            "x":33,
            "y":31,
            "width":254,
            "height":193
         },Global.Img_Cdm);
         ComponentUtil.getTextField("排名",this._mainLayer,{
            "x":54,
            "y":35,
            "color":16764206
         });
         ComponentUtil.getTextField("名字",this._mainLayer,{
            "x":128,
            "y":35,
            "color":16764206
         });
         ComponentUtil.getTextField("伤害",this._mainLayer,{
            "x":224,
            "y":35,
            "color":16764206
         });
         ComponentUtil.getTextField("我的排名：",this._mainLayer,{
            "x":45,
            "y":198,
            "color":13424242
         });
         this._tfMyRank = ComponentUtil.getTextField("000",this._mainLayer,{
            "x":103,
            "y":198,
            "color":16383744
         });
         ComponentUtil.getTextField("我的伤害：",this._mainLayer,{
            "x":165,
            "y":198,
            "color":13424242
         });
         this._tfMyDamage = ComponentUtil.getTextField("000.00%",this._mainLayer,{
            "x":223,
            "y":198,
            "color":16383744
         });
         ComponentUtil.getTextField("伤害排行榜",this._mainLayer,{
            "x":123,
            "y":6,
            "color":9893119
         });
         ComponentUtil.getButton("","Button_HDSeach",this._mainLayer,{
            "x":30,
            "y":2,
            "textColor":16184781,
            "callBack":this.rankClickHd
         },Global.Img_Cdm);
         this._btnIntroduce = ComponentUtil.getButton("","Button_Quest",this._mainLayer,{
            "x":240,
            "y":2,
            "callBack":this.introduceClickHd
         },Global.Img_Cdm);
         this._btnShow = ComponentUtil.getButton("显","Button_Round",this,{
            "x":267,
            "y":2,
            "textColor":16184781,
            "visible":false,
            "callBack":this.showClickHd
         },Global.Img_Cdm);
         this._btnHide = ComponentUtil.getButton("隐","Button_Round",this,{
            "x":267,
            "y":2,
            "textColor":16184781,
            "callBack":this.hideClickHd
         },Global.Img_Cdm);
         Global.control.registerCallBack(Msg_WorldBoss.DAMAGERANL_TRACE_INFO_UPDATE,this.onDataUpdate);
         y1 = 54;
         yInc = 28;
         i = 0;
         while(i < 5)
         {
            item = new Child_FightInfItem();
            item._tfRank.text = (i + 1).toString();
            item.x = 43;
            item.y = y1 + i * yInc;
            this._mainLayer.addChild(item);
            this._items.push(item);
            i += 1;
         }
      }
      
      private function onDataUpdate() : void
      {
         var i:int = 0;
         while(i < 5)
         {
            this._items[i].update(Model_WorldBoss._rankTrace[i]);
            i += 1;
         }
         this._tfMyRank.text = Enum_BroadCastTool.instance.getBitStr(Model_WorldBoss._myRank,3);
         this._tfMyDamage.text = (Model_WorldBoss._myDamagePercent / 100).toString() + "%";
      }
      
      private function rankClickHd(e:MouseEvent) : void
      {
         View_DamageRankPnl.instance.visible = !View_DamageRankPnl.instance.visible;
      }
      
      private function showClickHd(e:MouseEvent) : void
      {
         this._mainLayer.visible = true;
         this._btnShow.visible = false;
         this._btnHide.visible = true;
      }
      
      private function hideClickHd(e:MouseEvent) : void
      {
         this._mainLayer.visible = false;
         this._btnHide.visible = false;
         this._btnShow.visible = true;
      }
      
      private function introduceClickHd(e:MouseEvent) : void
      {
         var introduceView:View_WorldBossIntroduce = View_WorldBossIntroduce.instance;
         introduceView.visible = !introduceView.visible;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
      }
      
      override public function resetPosition() : void
      {
         x = Global.stage.stageWidth - width;
         y = 280;
      }
   }
}

