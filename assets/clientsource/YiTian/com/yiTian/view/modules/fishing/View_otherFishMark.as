package com.yiTian.view.modules.fishing
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.command.Enum_MsgType;
   import com.yiTian.data.Const_strImg;
   import com.yiTian.data.config.Enum_fishing;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.FishingCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.loading.View_loading;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TextEvent;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class View_otherFishMark extends Panel
   {
      
      private var titleBg:Bitmap;
      
      private var btn_refresh:Button;
      
      private var btn_snatch:Button;
      
      private var tf_name:MyTextField;
      
      private var _id:Number = 0;
      
      private var _count:int = 0;
      
      private var selectedSp:Sprite;
      
      private var bm_head:Bitmap;
      
      private var num_fish:int = 0;
      
      private var fishMarkItemVec:Vector.<Child_fishMarkItem>;
      
      public function View_otherFishMark()
      {
         super();
      }
      
      public function get currentRoleId() : Number
      {
         return this._id;
      }
      
      override protected function initStaticView() : void
      {
         var back:ScaleBitmap = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":308,
            "height":377
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":260,
            "height":300
         },Global.Img_Cdm);
         move = new Rectangle(0,0,back.width,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":260,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         this.tf_name = ComponentUtil.getTextField("",this,{
            "x":57,
            "y":50,
            "color":14662240,
            "size":12,
            "leading":0
         });
         this.btn_refresh = ComponentUtil.getButton(LangConfig.getWord("29093",2),"Button_Two64",this,{
            "x":210,
            "y":46,
            "textColor":16184781
         },Global.Img_Cdm);
         this.createItem(5);
         this.btn_snatch = ComponentUtil.getButton(LangConfig.getWord("60110",6),"Button_Four",this,{
            "x":125,
            "y":343,
            "textColor":16184781
         },Global.Img_Cdm);
         this.bm_head = new Bitmap();
         this.bm_head.x = 38;
         this.bm_head.y = 52;
         addChild(this.bm_head);
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
         this.btn_refresh.callBack = this.refreshClickHandle;
         this.btn_snatch.callBack = this.snatchClickHandle;
         this.selectedSp = new Sprite();
         this.selectedSp.graphics.beginFill(11184895,0.15);
         this.selectedSp.graphics.drawRect(0,0,250,50);
         this.selectedSp.graphics.endFill();
         this.tf_name.mouseEnabled = true;
         this.tf_name.addEventListener(TextEvent.LINK,function(evt:TextEvent):void
         {
            Global.control.sendNotification(Enum_MsgType.MSG_CHECKOTHERROLE,_id);
         });
         addEventListener(MouseEvent.CLICK,this.clickHandle);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2 + 100;
         y = (Global.stage.stageHeight - height) / 2 - 20;
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(!Global.Fishing_Imgsdm)
            {
               this.load();
            }
            else if(!this.titleBg)
            {
               this.sourceComplete();
            }
         }
         else if(value == false)
         {
            if(Boolean(this.selectedSp) && Boolean(this.selectedSp.parent))
            {
               this.selectedSp.parent.removeChild(this.selectedSp);
            }
         }
      }
      
      private function load() : void
      {
         var arr:Array = [];
         arr.push([Enum_fishing.FISHINGSOURCE,this.sourceComplete,LangConfig.getWord("20000",2),Enum_loaderType.SINGLE,Enum_resType.RES_URL]);
         View_loading.instance.load(arr,function():void
         {
            View_loading.instance.visible = false;
         });
      }
      
      private function sourceComplete(info:Object = null) : void
      {
         this.titleBg = ComponentUtil.getBitmap("Title_YuLan",this,{
            "x":74,
            "y":5
         },Global.Fishing_Imgsdm);
      }
      
      private function refreshClickHandle(evt:MouseEvent) : void
      {
         evt.stopPropagation();
         FishingCGMessage.CG_CHECK_FISH(Model_fishing.getInstance().currentRiverId,this._id);
      }
      
      private function createItem(count:int) : void
      {
         var posY1:Number = NaN;
         var offsetY:Number = NaN;
         var index:int = 0;
         var fmi:Child_fishMarkItem = null;
         this._count = count;
         posY1 = 75;
         offsetY = 52;
         this.fishMarkItemVec = new Vector.<Child_fishMarkItem>();
         index = 0;
         while(index < count)
         {
            fmi = new Child_fishMarkItem();
            fmi.x = 29;
            fmi.y = posY1 + offsetY * index;
            addChild(fmi);
            fmi.itemIndex = index + 1;
            this.fishMarkItemVec.push(fmi);
            index++;
         }
      }
      
      public function set id(value:Number) : void
      {
         var obj:Object = null;
         var _name:String = null;
         var dir:String = null;
         this._id = value;
         var dic:Dictionary = Model_fishing.getInstance().fishingPlayerDic;
         if(Boolean(dic[value]))
         {
            obj = dic[value];
            _name = HtmlUtil.createLink(Model_heFu.repNameByHero(obj.name));
            this.tf_name.htmlText = LangConfig.getWord("23320",2,_name);
            dir = Const_strImg.getPlayerHead(obj.job,obj.sex,3);
            this.bm_head = Utils.getLoadBitmap(dir,this.bm_head);
         }
         else
         {
            this.tf_name.text = "";
         }
      }
      
      private function snatchClickHandle(evt:MouseEvent) : void
      {
         var obj:Object = null;
         var num:int = 0;
         var item:Child_fishMarkItem = null;
         var fmi:Child_fishMarkItem = null;
         for each(obj in Model_fishing.getInstance().fishPlayerArr)
         {
            if(obj.id == this._id)
            {
               if(!this.selectedSp.parent || (this.selectedSp.parent as Child_fishMarkItem).isEmpty() == true)
               {
                  UIManager.centerBroadcast.addMsg(LangConfig.getWord("23319",2));
               }
               else
               {
                  num = 0;
                  for each(item in this.fishMarkItemVec)
                  {
                     if(item.data != null)
                     {
                        num += 1;
                     }
                  }
                  if(num == 1)
                  {
                     UIManager.centerBroadcast.addMsg(LangConfig.getWord("23321",2));
                     return;
                  }
                  fmi = this.selectedSp.parent as Child_fishMarkItem;
                  FishingCGMessage.CG_SNATCH_FISH(this._id,Model_fishing.getInstance().currentRiverId,fmi.itemIndex,fmi.data as int,this.num_fish);
               }
               evt.stopPropagation();
               return;
            }
         }
         UIManager.centerBroadcast.addMsg(LangConfig.getWord("23322",2));
         this.visible = false;
      }
      
      public function set data(value:Array) : void
      {
         this.num_fish = value.length;
         var index:int = 0;
         while(index < this._count)
         {
            this.fishMarkItemVec[index].data = value[index];
            index++;
         }
      }
      
      public function get id() : Number
      {
         return this._id;
      }
      
      private function clickHandle(evt:MouseEvent) : void
      {
         var fmi:Child_fishMarkItem = null;
         evt.stopPropagation();
         if(evt.target is Child_fishMarkItem)
         {
            fmi = evt.target as Child_fishMarkItem;
            fmi.addChild(this.selectedSp);
         }
      }
   }
}

