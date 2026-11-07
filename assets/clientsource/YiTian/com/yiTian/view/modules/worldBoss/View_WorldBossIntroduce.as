package com.yiTian.view.modules.worldBoss
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.Panel;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Rectangle;
   import flash.text.TextFieldAutoSize;
   
   public class View_WorldBossIntroduce extends Panel
   {
      
      private var _tfTitle:MyTextField;
      
      private var _tfIntroduce:MyTextField;
      
      public function View_WorldBossIntroduce()
      {
         super();
         init();
      }
      
      public static function get instance() : View_WorldBossIntroduce
      {
         return Singleton.getInstance(View_WorldBossIntroduce);
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":380,
            "height":293
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":332,
            "height":243
         },Global.Img_Cdm);
         this._tfTitle = ComponentUtil.getTextField("玩法介绍",this,{
            "y":7,
            "size":14,
            "color":16641706,
            "bold":true
         });
         this._tfTitle.realWidth = width;
         this._tfTitle.autoSize = TextFieldAutoSize.CENTER;
         this._tfTitle.filters = [new GlowFilter(39253,1,6,6,10)];
         move = new Rectangle(0,0,width,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":width - 36,
            "y":5,
            "callBack":this.closeClickHd
         },Global.Img_Cdm);
         this._tfIntroduce = ComponentUtil.getTextField("",this,{
            "realWidth":320,
            "size":14,
            "x":30,
            "y":45,
            "color":14013809
         });
         this._tfIntroduce.wordWrap = true;
         this._tfIntroduce.multiline = true;
      }
      
      override protected function initDynamicView() : void
      {
         this._tfIntroduce.htmlText = "1、30级以上竞技场排名前500的玩家，可以参与世界boss挑战<br>2、每天的14:25分可以进入武魂地图，14:30正式开始挑战世界boss<br>3、世界boss每掉20%血会放出一定数量的武魂宝箱，采集宝箱可获得珍贵道具和传功buff<br>4、伤害排名前10或者完成最后一击可获得丰厚奖励，排名11-100随机挑选20名玩家给予幸运奖(非绑定)<br>5、每次攻击世界boss都有机会偷取到武魂宝箱<br>6、使用元宝或者礼券传功可以大幅度增加攻击力<br>7、当天武魂灵气值越高，召唤出来的世界boss品质越高，奖励越多";
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
      
      private function closeClickHd(e:MouseEvent) : void
      {
         visible = false;
      }
   }
}

