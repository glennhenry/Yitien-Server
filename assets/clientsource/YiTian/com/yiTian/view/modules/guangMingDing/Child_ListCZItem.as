package com.yiTian.view.modules.guangMingDing
{
   import Layout.VGroup;
   import com.ui.controls.Button;
   import com.ui.controls.CheckBox;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.TipManager;
   import com.yiTian.net.handler.GuangMingDingCGMessage;
   import com.yiTian.view.comp.View_Grid;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class Child_ListCZItem extends Sprite
   {
      
      private var _rewardsGridLay:VGroup;
      
      private var _rewardsArr:Array = [];
      
      private var _tfRemain:MyTextField;
      
      private var _tfBestRecord:MyTextField;
      
      public var _cbPassWord:CheckBox;
      
      private var _btnIntroduce:Button;
      
      public function Child_ListCZItem()
      {
         var vo:Vo_item = null;
         super();
         ComponentUtil.getBitmap("Back_02",this,{
            "x":0,
            "y":0
         },Global.GuangMingDing_Imgdm);
         ComponentUtil.getBitmap("FuBen_Img",this,{
            "x":9,
            "y":9
         },Global.GuangMingDing_Imgdm);
         this._tfRemain = ComponentUtil.getTextField("",this,{
            "x":23,
            "y":52,
            "color":16777215,
            "size":12,
            "leading":0
         });
         this._tfBestRecord = ComponentUtil.getTextField("",this,{
            "x":23,
            "y":74,
            "color":16777215,
            "size":12,
            "leading":0
         });
         ComponentUtil.getButton("","Button_ChuangJian",this,{
            "x":178,
            "y":297,
            "callBack":this.createClickHd
         },Global.GuangMingDing_Imgdm);
         ComponentUtil.getButton("","Button_KSJR",this,{
            "x":19,
            "y":317,
            "callBack":this.fastJoinClickHd
         },Global.GuangMingDing_Imgdm);
         ComponentUtil.getButton("","Button_ChaZhao",this,{
            "x":98,
            "y":317,
            "callBack":this.searchClickHd
         },Global.GuangMingDing_Imgdm);
         this._btnIntroduce = ComponentUtil.getButton("","Button_WFSM",this,{
            "x":224,
            "y":12,
            "callBack":this.introduceClickHd
         },Global.GuangMingDing_Imgdm);
         this._cbPassWord = ComponentUtil.getCheckBox("创建时设置密码","CheckBox01",this,{
            "x":25,
            "y":296,
            "color":16777215
         },Global.Img_Cdm);
         this._rewardsGridLay = new VGroup(26,247,0,0,0,49);
         var gridInfos:Array = [];
         var info:Array = GuangMingDingConfig.getStaticRewards();
         var ii:int = 0;
         while(ii < info.length)
         {
            vo = new Vo_item();
            vo.id = info[ii];
            vo.Init_lib();
            gridInfos.push(vo);
            ii += 1;
         }
         this.updateRewards(gridInfos);
         this.recordUpdateHd(Model_guangMingDing.record);
         this.remainUpdateHd(Model_guangMingDing.remain);
         Global.control.registerCallBack(Msg_guangMingDing.GMD_RECORD_UPDATE,this.recordUpdateHd);
         Global.control.registerCallBack(Msg_guangMingDing.GMD_REMAIN_UPDATE,this.remainUpdateHd);
         TipManager.bind(this._btnIntroduce,GuangMingDingConfig.getIntroduceTxt());
      }
      
      private function recordUpdateHd(value:int) : void
      {
         this._tfBestRecord.htmlText = GuangMingDingConfig.getRecordTxt(value);
      }
      
      private function remainUpdateHd(value:int) : void
      {
         this._tfRemain.htmlText = GuangMingDingConfig.getRemainTimsTxt(value);
      }
      
      public function updateRewards(infos:Object) : void
      {
         var vo:Vo_item = null;
         var grid:View_Grid = null;
         for each(vo in infos)
         {
            grid = new View_Grid();
            grid.set_bmp_bg();
            grid.set_bmp_over(true,null);
            grid.vo = vo;
            addChild(grid);
            this._rewardsArr.push(grid);
            this._rewardsGridLay.appendItem(grid);
         }
         this._rewardsGridLay.align();
      }
      
      private function searchClickHd(e:MouseEvent) : void
      {
         View_gmdSearchRoom.instance.changeVis();
      }
      
      private function fastJoinClickHd(e:MouseEvent) : void
      {
         GuangMingDingCGMessage.CG_GMD_FAST_JOIN();
      }
      
      private function createClickHd(e:MouseEvent) : void
      {
         if(this._cbPassWord.selected)
         {
            View_gmdPassWordChangePnl.instance.changeVis();
         }
         else
         {
            GuangMingDingCGMessage.CG_GMD_CREATE_ROOM(0,"");
         }
      }
      
      private function introduceClickHd(e:MouseEvent) : void
      {
      }
   }
}

