package com.yiTian.view.modules.vipBGift
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.Enum_vipBGift;
   import com.yiTian.data.model.Model_vipBGift;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.VipBGiftCGMessage;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mx.utils.StringUtil;
   
   public class HGJJ extends Sprite
   {
      
      private var _index:int;
      
      private var title_txt:MyTextField;
      
      private var realPrice_txt:MyTextField;
      
      private var zkPrice_txt:MyTextField;
      
      private var remain_txt:MyTextField;
      
      private var buy_button:Button;
      
      private var gird:View_Grid;
      
      private var maxBuy:int = 0;
      
      public function HGJJ()
      {
         super();
         this.initUI();
      }
      
      private function initUI() : void
      {
         ComponentUtil.getBitmap("Back_HGJJ",this,{
            "x":1,
            "y":0
         },Global.WHHGdm);
         ComponentUtil.getBitmap("grid_ShangCheng",this,{
            "x":8,
            "y":8
         },Global.Img_Cdm);
         this.buy_button = ComponentUtil.getButton("","Button_Orange",this,{
            "x":99,
            "y":79,
            "textColor":16771436,
            "callBack":this.onBuyHandler
         },Global.Img_Cdm);
         this.title_txt = ComponentUtil.getTextField("优惠武魂礼包",this,{
            "x":98,
            "y":13,
            "color":3644132,
            "size":12,
            "leading":0
         });
         this.realPrice_txt = ComponentUtil.getTextField("价值：5000元宝",this,{
            "x":93,
            "y":38,
            "color":11904647,
            "size":12,
            "leading":0
         });
         this.zkPrice_txt = ComponentUtil.getTextField("现价：4000元宝",this,{
            "x":93,
            "y":54,
            "color":16383744,
            "size":12,
            "leading":0
         });
         this.remain_txt = ComponentUtil.getTextField("限购 0/10",this,{
            "x":17,
            "y":82,
            "color":16383744,
            "size":12,
            "leading":0
         });
         ComponentUtil.getTextField("购买",this,{
            "x":121,
            "y":82,
            "color":16773818,
            "size":12,
            "leading":0
         });
         ComponentUtil.getBitmap("line_HGJJ",this,{
            "x":129,
            "y":42
         },Global.WHHGdm);
         this.gird = new View_Grid(true);
         ComponentUtil.setPropertie(this.gird,{
            "x":10,
            "y":10
         });
         this.addChild(this.gird);
      }
      
      private function onBuyHandler(evt:MouseEvent) : void
      {
         if(GameUnitManager.hero.money < Enum_vipBGift.PRICE[this.index])
         {
            UIManager.centerBroadcast.addMsg("元宝不足!");
            return;
         }
         Model_vipBGift.curIndex = this.index;
         VipBGiftCGMessage.CG_VIPBG_BUYGIFT(this.index);
      }
      
      public function toolFly() : void
      {
         if(Boolean(this.gird))
         {
            Tween.gridToBagBezierFuncDef(this.gird);
         }
      }
      
      public function setdata(count:int) : void
      {
         this.remain_txt.text = StringUtil.substitute("限购 {0}/" + this.maxBuy,count);
      }
      
      public function get index() : int
      {
         return this._index;
      }
      
      public function set index(value:int) : void
      {
         this._index = value;
         this.gird.empty();
         var vo2:Vo_item = new Vo_item();
         var b:* = Data_lib.VIPjijinlibao[this.index];
         this.maxBuy = b[2];
         var ids:String = b[3];
         vo2.id = ids.split("_")[1];
         vo2.Init_lib();
         this.title_txt.text = b[0];
         this.gird.set_bmp_over(true,"");
         this.gird.vo = vo2;
         this.gird.set_tf_count(true);
         this.gird.count = ids.split("_")[2];
         var p:Array = b[1].split("_");
         this.remain_txt.text = StringUtil.substitute("限购 {0}/" + this.maxBuy,p[2]);
         this.realPrice_txt.text = StringUtil.substitute("价值：{0}元宝",p[0]);
         this.zkPrice_txt.text = StringUtil.substitute("现价：{0}元宝",p[1]);
      }
   }
}

