package com.yiTian.view.modules.marriage
{
   import com.event.TextField_h;
   import com.ui.controls.*;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.data.vo.Vo_item;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.TipManager;
   import com.yiTian.net.handler.MarriageHandler;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.loading.View_loading;
   import flash.display.*;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldAutoSize;
   
   public class View_GetMarriagePlane extends Panel
   {
      
      private var _data:Object = null;
      
      private var btn_agree:Button;
      
      private var btn_oppose:Button;
      
      private var tf_title:MyTextField;
      
      private var tf_name:TextField_h;
      
      private var tf_else:MyTextField;
      
      private var bg_back:DisplayObjectContainer;
      
      private var bg_bok:Bitmap;
      
      private const WIDTH:int = 605;
      
      private const HEIGHT:int = 468;
      
      private var vo:Vo_item;
      
      private var bm:Bitmap;
      
      private var contain:Sprite = new Sprite();
      
      private var isUIComplete:Boolean = false;
      
      public function View_GetMarriagePlane()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         this.bg_back = new Sprite();
         this.bg_back.mouseEnabled = false;
         this.addChild(this.bg_back);
         move = new Rectangle(0,0,this.WIDTH,this.HEIGHT);
         CloseButton = ComponentUtil.getButton("","NPC_Close",this,{
            "x":494,
            "y":64
         },Global.Img_Cdm);
         this.tf_name = ComponentUtil.getTextField_h("",this,{
            "x":355,
            "y":210
         });
         this.tf_name.autoSize = TextFieldAutoSize.RIGHT;
         this.contain.x = 377.65;
         this.contain.y = 174.5;
         addChild(this.contain);
      }
      
      private function onAgree(evt:MouseEvent) : void
      {
         MarriageHandler.CG_MARRIAGE_INITIATE(0);
         this.visible = false;
      }
      
      private function onOppose(evt:MouseEvent) : void
      {
         MarriageHandler.CG_MARRIAGE_INITIATE(-1);
         this.visible = false;
      }
      
      private function askSceneOKHd() : void
      {
         this.visible = false;
         Global.control.removeCallBack(Enum_MsgType.MSG_ASK_CHANGE_SCENE_OK,this.askSceneOKHd);
      }
      
      override public function resetPosition() : void
      {
         this.x = Global.stage.stageWidth / 2 - this.WIDTH / 2;
         this.y = Global.stage.stageHeight / 2 - this.HEIGHT / 2;
      }
      
      public function get data() : Object
      {
         return this._data;
      }
      
      override public function set visible(value:Boolean) : void
      {
         var arr:Array = null;
         if(value)
         {
            if(!this.isUIComplete)
            {
               if(!Global.Marry_Imgsdm)
               {
                  arr = [];
                  arr.push(["lang/ch/Marry_Imgs.swf",function(info:Object):void
                  {
                     Global.Marry_Imgsdm = info.applicationDomain;
                  },LangConfig.getWord("20000",2),Enum_loaderType.SINGLE,Enum_resType.RES_URL]);
                  View_loading.instance.load(arr,function():void
                  {
                     initT();
                     visible = true;
                     View_loading.instance.visible = false;
                  });
                  return;
               }
               this.initT();
            }
            Global.control.registerCallBack(Enum_MsgType.MSG_ASK_CHANGE_SCENE_OK,this.askSceneOKHd);
         }
         super.visible = value;
      }
      
      private function initT() : void
      {
         ComponentUtil.getBitmap("Back_Marry",this.bg_back,{
            "x":0,
            "y":0
         },Global.Marry_Imgsdm);
         this.btn_agree = ComponentUtil.getButton(LangConfig.getWord("60217",6),"Button_Marry",this,{
            "x":198,
            "y":280,
            "textColor":16184781
         },Global.Marry_Imgsdm);
         this.btn_agree.callBack = this.onAgree;
         this.btn_oppose = ComponentUtil.getButton(LangConfig.getWord("60218",6),"Button_Marry",this,{
            "x":317,
            "y":280,
            "textColor":16184781
         },Global.Marry_Imgsdm);
         this.btn_oppose.callBack = this.onOppose;
      }
      
      public function set data(value:Object) : void
      {
         this._data = value;
         if(this.data != null && this.data.hasOwnProperty("name"))
         {
            this.tf_name.htmlText = LangConfig.getWord("1066",0,this.data.name);
         }
         this.vo = new Vo_item();
         this.vo.id = this.data.ringID;
         this.vo.Init_lib();
         var path:String = "resource/image/icon60/" + this.data.ringID + ".png";
         if(Boolean(this.bm) && this.contain.contains(this.bm))
         {
            this.contain.removeChild(this.bm);
            this.bm = null;
         }
         this.bm = Utils.getLoadBitmap(path);
         this.contain.addChild(this.bm);
         var color:String = Model_Marriage.getColorStrByVoColor(this.vo.color);
         var msg2:String = LangConfig.getWord("1067",0,color,this.vo.str_name);
         TipManager.bind(this.contain,msg2);
      }
   }
}

