package com.yiTian.view.modules.activity.kaifuItem
{
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.ModalUIManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.KaiFuDiscountCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Singleton;
   import com.yiTian.view.UIBase123;
   import com.yiTian.view.comp.View_Grid;
   import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
   import flash.events.MouseEvent;
   import flash.text.TextFieldAutoSize;
   
   public class View_kaiFuDiscountPnl extends UIBase123
   {
      
      public var _tfInfo:MyTextField;
      
      public var _grid:View_Grid;
      
      public var _tfCurrentValue:MyTextField;
      
      public var _tfFullValue:MyTextField;
      
      public var _gridItemID:int;
      
      public var _gridIndex:int;
      
      public var _itemIndex:int;
      
      public var _srcXml:XML;
      
      public function View_kaiFuDiscountPnl()
      {
         super();
         bindParent = GameScene.modalLayer;
         regResource("lang/ch/JCHD.swf","JCHDdm");
         regResource("resource/moduleConfig/kaifuModule/kaifuRebateDatas.xml","",2);
      }
      
      public static function get instance() : View_kaiFuDiscountPnl
      {
         return Singleton.getInstance(View_kaiFuDiscountPnl);
      }
      
      override protected function initUI2() : void
      {
         this._srcXml = XML(getCfg(0));
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":328,
            "height":194
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":25,
            "y":40,
            "width":278,
            "height":144
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_Prompt",this,{
            "x":84,
            "y":5
         },Global.Img_Cdm);
         ComponentUtil.getButton("","Button_Close",this,{
            "x":293,
            "y":6,
            "callBack":this.cancelClickHandler
         },Global.Img_Cdm);
         this._grid = new View_Grid();
         this._grid.x = 94;
         this._grid.y = 61;
         this._grid.set_bmp_bg();
         this._grid.set_bmp_over(true,null);
         this._grid.set_tf_count(true);
         addChild(this._grid);
         this._tfFullValue = ComponentUtil.getTextField("",this,{
            "x":146,
            "y":58,
            "color":16777011,
            "leading":4
         });
         this._tfCurrentValue = ComponentUtil.getTextField("",this,{
            "x":146,
            "y":78,
            "color":16777011,
            "leading":4
         });
         this._tfInfo = ComponentUtil.getTextField("",this,{
            "y":116,
            "color":16777215
         });
         this._tfInfo.realWidth = 328;
         this._tfInfo.autoSize = TextFieldAutoSize.CENTER;
         ComponentUtil.getBitmap("Back_ErZhe",this,{
            "x":105,
            "y":54
         },Global.JCHDdm);
         ComponentUtil.getBitmap("Line_YuanJia",this,{
            "x":182,
            "y":62
         },Global.JCHDdm);
         ComponentUtil.getButton("确定","Button_Four",this,{
            "x":76,
            "y":146,
            "textColor":16771436,
            "callBack":this.okClickHandler
         },Global.Img_Cdm);
         ComponentUtil.getButton("取消","Button_Four",this,{
            "x":180,
            "y":146,
            "textColor":16771436,
            "callBack":this.cancelClickHandler
         },Global.Img_Cdm);
      }
      
      public function show(id:int, gridIndex:int) : void
      {
         var ins:UIBase123 = null;
         this._gridItemID = id;
         this._gridIndex = gridIndex;
         ins = this;
         Global.delegate.dosomething(ins,function():void
         {
            ModalUIManager.POPUP(ins);
         });
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(value)
         {
            this.updateGrid();
         }
         super.visible = value;
      }
      
      private function updateGrid() : void
      {
         var xml:XML = null;
         var tXml:XML = null;
         var vo:Vo_item = null;
         var type:int = 0;
         var fullVal:int = 0;
         var cur:int = 0;
         xml = this._srcXml;
         tXml = xml.item.(useToolid == _gridItemID.toString())[0];
         vo = new Vo_item();
         type = int(tXml[0].type);
         this._itemIndex = tXml[0].id;
         vo.id = tXml[0].toolId;
         vo.count = tXml[0].num;
         vo.Init_lib();
         this._grid.vo = vo;
         fullVal = int(tXml[0].fullValue);
         cur = int(tXml[0].value);
         this._tfFullValue.htmlText = LangConfig.reTxt(this._srcXml.fullValueRep,fullVal);
         this._tfCurrentValue.htmlText = LangConfig.reTxt(this._srcXml.nowValueRep,cur);
         this._tfInfo.htmlText = LangConfig.reTxt(xml.buyRep,cur,Enum_BroadCastTool.instance.getItemText(vo.id));
      }
      
      private function okClickHandler(e:MouseEvent) : void
      {
         var tXml:XML = null;
         var cost:int = 0;
         tXml = this._srcXml.item.(useToolid == _gridItemID.toString())[0];
         cost = int(tXml[0].value);
         if(GameUnitManager.hero.money < cost)
         {
            UIManager.centerBroadcast.addMsg("元宝不足，请及时充值");
            return;
         }
         if(CommandManager.get_bag_canUse() < 1)
         {
            UIManager.centerBroadcast.addMsg("背包容量不足，请清理背包");
            return;
         }
         KaiFuDiscountCGMessage.CG_BUY_DISCOUNT(this._itemIndex,1);
         ModalUIManager.UNPOP();
      }
      
      private function cancelClickHandler(e:MouseEvent) : void
      {
         ModalUIManager.UNPOP();
      }
      
      override public function get width() : Number
      {
         return 328;
      }
      
      override public function get height() : Number
      {
         return 194;
      }
   }
}

