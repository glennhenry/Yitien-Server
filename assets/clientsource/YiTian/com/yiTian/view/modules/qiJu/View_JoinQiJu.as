package com.yiTian.view.modules.qiJu
{
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_QiJu;
   import com.yiTian.data.model.Model_QiJu;
   import com.yiTian.net.message.cg.QiJuCGMessage;
   import com.yiTian.view.Panel123;
   import flash.geom.Rectangle;
   
   public class View_JoinQiJu extends Panel123
   {
      
      private static var _instance:View_JoinQiJu;
      
      private var myTeam:Child_MyTeam;
      
      private var list:Child_List;
      
      public function View_JoinQiJu()
      {
         super();
         init();
      }
      
      public static function get instance() : View_JoinQiJu
      {
         if(!_instance)
         {
            _instance = new View_JoinQiJu();
         }
         return _instance;
      }
      
      public function setTime() : void
      {
         this.list.setTime();
      }
      
      public function upDataGrid(type:int) : void
      {
         this.myTeam.upDataGrid(type);
      }
      
      public function upTeamList() : void
      {
         this.list.showList();
      }
      
      public function upMyTeam() : void
      {
         this.myTeam.show(Model_QiJu.team_id != 0);
      }
      
      public function upCreatList(arr:Array) : void
      {
         this.myTeam.upCreatList(arr);
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":620,
            "height":365
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":22,
            "y":38,
            "width":575,
            "height":316
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":31,
            "y":46,
            "width":357,
            "height":271
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":33,
            "y":48,
            "width":353,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":391,
            "y":45,
            "width":199,
            "height":270
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":393,
            "y":47,
            "width":195,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":393,
            "y":186,
            "width":195,
            "height":20
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_TouZi",[13,13,2,2],this,{
            "x":393,
            "y":67,
            "width":195,
            "height":115
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_TouZi",[13,13,2,2],this,{
            "x":393,
            "y":206,
            "width":195,
            "height":107
         },Global.Img_Cdm);
         move = new Rectangle(0,0,620,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":586,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
         this.list = new Child_List();
         addChild(this.list);
         ComponentUtil.setPropertie(this.list,{
            "x":34,
            "y":47
         });
         this.myTeam = new Child_MyTeam();
         addChild(this.myTeam);
         ComponentUtil.setPropertie(this.myTeam,{
            "x":393,
            "y":47
         });
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         Model_QiJu.isJoinPnlShow = value;
         if(value)
         {
            QiJuCGMessage.CG_OPEN_QIJU();
            if(!Global.ZLQiJundm)
            {
               regResource(Enum_QiJu.QIJUSOURCE,"ZLQiJundm");
               preFun();
            }
         }
         else
         {
            if(Model_QiJu.inQijuGame)
            {
               return;
            }
            QiJuCGMessage.CG_EXIT_QIJU_TEAM(1);
         }
      }
      
      override protected function initUI2() : void
      {
         ComponentUtil.getBitmap("BT_ZL_txt",this,{
            "x":230,
            "y":5
         },Global.ZLQiJundm);
         this.myTeam.showTeamIcon();
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

