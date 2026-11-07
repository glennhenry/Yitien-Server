package com.yiTian.view.modules.map
{
   import com.ui.controls.TabButton;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.utils.SingleLoader;
   import com.yiTian.view.Enum_explor;
   import com.yiTian.view.Panel;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class MapPanel extends Panel
   {
      
      private var Button_Current:TabButton;
      
      private var Button_World:TabButton;
      
      private var currentMap:CurrentMap;
      
      private var worldMap:WorldMap;
      
      private var now:TabButton;
      
      private var isFirstOpen:Boolean = true;
      
      public function MapPanel()
      {
         super();
      }
      
      public function get curMap() : CurrentMap
      {
         return this.currentMap;
      }
      
      override protected function initStaticView() : void
      {
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":598,
            "height":420
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":550,
            "height":370
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":34,
            "y":70,
            "width":530,
            "height":330
         },Global.Img_Cdm);
         move = new Rectangle(0,0,560,36);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":564,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_Current = ComponentUtil.getTabButton(LangConfig.getWord("10607",1),"TabButton_Four",this,{
            "x":40,
            "y":49,
            "textColor":12232795,
            "chooseColor":16773818
         },Global.Img_Cdm);
         this.Button_World = ComponentUtil.getTabButton(LangConfig.getWord("10608",1),"TabButton_Four",this,{
            "x":116,
            "y":49,
            "textColor":12232795,
            "chooseColor":16773818
         },Global.Img_Cdm);
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
         this.currentMap = new CurrentMap();
         addChild(this.currentMap);
         this.Button_Current.binding = this.currentMap;
         this.currentMap.x = 19;
         this.currentMap.y = 2;
         this.worldMap = new WorldMap();
         addChild(this.worldMap);
         this.Button_World.binding = this.worldMap;
         this.worldMap.x = 19;
         this.worldMap.y = 2;
         this.Button_World.addEventListener(MouseEvent.CLICK,this.clickEvent);
         this.Button_Current.addEventListener(MouseEvent.CLICK,this.clickEvent);
         this.Button_Current.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
      }
      
      public function clickEvent(e:MouseEvent) : void
      {
         var btn:TabButton = e.target as TabButton;
         if(this.now == btn)
         {
            return;
         }
         if(Boolean(this.now))
         {
            this.now.choose = false;
         }
         btn.choose = true;
         this.now = btn;
      }
      
      public function watch() : void
      {
         this.currentMap.watch();
      }
      
      public function refresh() : void
      {
         this.currentMap.refresh();
      }
      
      public function setRotation(rotation:Number) : void
      {
         this.currentMap.setRotation(rotation);
      }
      
      public function drawPath(path:Array) : void
      {
         this.currentMap.drawPath(path);
      }
      
      public function clearPath() : void
      {
         this.currentMap.clearPath();
      }
      
      public function addTeamPoint(guid:int, $name:String, global_x:int, global_y:int) : void
      {
         this.currentMap.addTeamPoint(guid,$name,global_x,global_y);
      }
      
      public function refreshTeamPoint(guid:int, global_x:int, global_y:int) : void
      {
         this.currentMap.refreshTeamPoint(guid,global_x,global_y);
      }
      
      public function delTeamPoint(guid:int) : void
      {
         this.currentMap.delTeamPoint(guid);
      }
      
      public function delTeamPoints() : void
      {
         this.currentMap.delTeamPoints();
      }
      
      public function setSXM() : void
      {
         this.visible = true;
         this.Button_World.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
      
      private function showBmp() : void
      {
         ComponentUtil.getBitmap("Title_Map",this,{
            "x":219,
            "y":5
         },Global.Map_Imgsdm);
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(this.isFirstOpen)
            {
               this.isFirstOpen = false;
               bind_target = Enum_explor.bind(Enum_explor.BTN_MAP);
               SingleLoader.add("lang/ch/Map_Imgs.swf",function(info:Object):void
               {
                  Global.Map_Imgsdm = info.applicationDomain;
                  showBmp();
               });
            }
            this.Button_Current.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
      }
   }
}

