package com.yiTian.view.modules.friends
{
   import com.event.TextField_h;
   import com.ui.controls.*;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.data.config.valuable.Enum_filter;
   import com.yiTian.data.vo.Vo_unit;
   import com.yiTian.data.vo.Vo_valuable;
   import com.yiTian.manager.CommandManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.FriendCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.Panel;
   import com.yiTian.view.comp.View_Alert;
   import com.yiTian.view.modules.loading.View_loading;
   import flash.display.Bitmap;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class View_BestowFlower extends Panel
   {
      
      private var _data:Object = null;
      
      private var typeGroup:RadioButtonGroup;
      
      private var flowerTypeGroup:Array;
      
      private var nm:int;
      
      private var flowerType:int;
      
      private var flowerNum:int;
      
      private var bg_back:DisplayObjectContainer;
      
      private const WIDTH:int = 605;
      
      private const HEIGHT:int = 468;
      
      private var fl_num1:int = 1;
      
      private var fl_num2:int = 99;
      
      private var fl_num3:int = 999;
      
      private var fl_arr:Array = new Array();
      
      private var selectItem:View_FlowerItem;
      
      private var fl_cost:Array = [int(1),int(99),int(999)];
      
      private var fl_costYB:Array = ["3","260","2500"];
      
      private const FLOWER_ITMEID:int = 46439;
      
      private var friendCombox:ComboBox;
      
      private var isUIComplete:Boolean = false;
      
      private var dataArr:Array;
      
      public var isNiName:Boolean = false;
      
      public function View_BestowFlower()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var tf_tips:TextField_h;
         this.bg_back = new Sprite();
         this.bg_back.mouseEnabled = false;
         this.addChild(this.bg_back);
         move = new Rectangle(0,0,this.WIDTH,this.HEIGHT);
         CloseButton = ComponentUtil.getButton("","NPC_Close",this,{
            "x":494,
            "y":64
         },Global.Img_Cdm);
         this.getTypeGroup();
         this.getFlowerTypeGroup();
         this.friendCombox = new ComboBox(new Array(),function(value:Object):void
         {
            data = {
               "name":value.name,
               "id":value.id
            };
         },180,"Button_PageDown","ComboBox_background");
         ComponentUtil.setPropertie(this.friendCombox,{
            "x":215,
            "y":170
         });
         addChild(this.friendCombox);
         tf_tips = ComponentUtil.getTextField_h(HtmlUtil.font(LangConfig.getWord("29255",2),"#F4CD31"),this,{
            "x":222.9,
            "y":340
         });
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
         }
         super.visible = value;
      }
      
      private function initT() : void
      {
         var bm:Bitmap = null;
         this.isUIComplete = true;
         bm = new Bitmap();
         bm.bitmapData = ComponentUtil.getBitmapData("Back_Marry",Global.Marry_Imgsdm);
         this.bg_back.addChild(bm);
         var btn_send:Button = ComponentUtil.getButton(LangConfig.getWord("29256",2),"Button_Marry",this,{
            "x":267,
            "y":300
         },Global.Marry_Imgsdm);
         btn_send.callBack = this.onClick;
      }
      
      private function onClick(evt:MouseEvent) : void
      {
         var alert:String = null;
         var id:Number = NaN;
         var heroName:String = null;
         var isKuafu:int = 0;
         var vec:Vector.<Vo_valuable> = CommandManager.get_bag_vec(Enum_filter.ITEM_ALL);
         this.nm = int(this.typeGroup.selectedItem.value);
         this.flowerType = this.selectItem.type + 1;
         this.flowerNum = this.selectItem.flowerNum;
         var hasFlower:Boolean = false;
         var str:String = this.fl_costYB[this.flowerType - 1];
         var count:int = 0;
         var i:int = 0;
         while(i < vec.length)
         {
            if(vec[i] != null && vec[i].id == this.FLOWER_ITMEID)
            {
               count += vec[i].count;
               if(count >= this.fl_cost[this.flowerType - 1])
               {
                  hasFlower = true;
                  break;
               }
            }
            i++;
         }
         if(!hasFlower)
         {
            alert = LangConfig.getWord("29259",2).replace("%ybcost",str).replace("%num",this.flowerNum.toString());
            View_Alert.show(alert,View_Alert.OK_CANCAL,this.useYB);
         }
         else if(Boolean(this.friendCombox.selValue))
         {
            id = Number((this.friendCombox.selValue as Object).id);
            heroName = (this.friendCombox.selValue as Object).name;
            isKuafu = heroName.match(/\.[sS]/g).length > 0 ? 1 : 0;
            FriendCGMessage.CG_SEND_FLOWER(id,this.nm,this.flowerType,1,heroName,isKuafu);
         }
         else
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("60121",6));
         }
      }
      
      private function useYB() : void
      {
         var isKuafu:int = 0;
         var voObj:Object = this.friendCombox.selValue;
         if(!voObj)
         {
            UIManager.centerBroadcast.addMsg("角色信息有误");
            return;
         }
         var heroName:String = voObj.name;
         if(GameUnitManager.hero.money < 3 && this.flowerType == 1)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("139",0));
         }
         else if(GameUnitManager.hero.money < 260 && this.flowerType == 2)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("139",0));
         }
         else if(GameUnitManager.hero.money < 2500 && this.flowerType == 3)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("139",0));
         }
         else if(Boolean(voObj) || Boolean(this.data))
         {
            isKuafu = heroName.match(/\.[sS]/g).length > 0 ? 1 : 0;
            if(this.data != null)
            {
               FriendCGMessage.CG_SEND_FLOWER(this.data.id,this.nm,this.flowerType,2,heroName,isKuafu);
            }
            else
            {
               FriendCGMessage.CG_SEND_FLOWER(voObj.id,this.nm,this.flowerType,2,heroName,isKuafu);
            }
         }
      }
      
      private function getTypeGroup() : void
      {
         this.typeGroup = new RadioButtonGroup();
         addChild(this.typeGroup);
         this.typeGroup.direction = RadioButtonGroup.HORIZONTAL;
         this.typeGroup.x = 205.9;
         this.typeGroup.y = 202.5;
         this.typeGroup.space = 180;
         var rb_qm:RadioButton = ComponentUtil.getRadioButton(LangConfig.getWord("29257",2),"CheckBox",this.typeGroup,{"value":1});
         var rb_nm:RadioButton = ComponentUtil.getRadioButton(LangConfig.getWord("29258",2),"CheckBox",this.typeGroup,{"value":2});
         this.typeGroup.selectedItem = rb_qm;
      }
      
      private function getFlowerTypeGroup() : void
      {
         var temp:View_FlowerItem = null;
         var i:int = 0;
         while(i < 3)
         {
            temp = new View_FlowerItem(this.fl_cost[i],i);
            addChild(temp);
            temp.x = 119 + i * 130;
            temp.y = 237;
            temp.addEventListener(MouseEvent.CLICK,this.onClickFlowerItem);
            temp.alpha = 0.3;
            this.fl_arr.push(temp);
            i++;
         }
         this.selectItem = this.fl_arr[0];
         this.fl_arr[0].alpha = 1;
      }
      
      private function onClickFlowerItem(evt:MouseEvent) : void
      {
         var i:int = 0;
         while(i < this.fl_arr.length)
         {
            this.fl_arr[i].alpha = 0.3;
            i++;
         }
         evt.target.alpha = 1;
         this.selectItem = evt.target as View_FlowerItem;
      }
      
      override public function resetPosition() : void
      {
         this.x = Global.stage.stageWidth / 2 - this.width / 2;
         this.y = Global.stage.stageHeight / 2 - this.height / 2;
      }
      
      public function show(roleID:Number = 0, roleName:String = null) : void
      {
         var o:* = undefined;
         var src:Array = null;
         var ddd:Object = null;
         var pushFlag:Boolean = false;
         var vo:Vo_unit = null;
         var a:Array = null;
         var others:Object = null;
         var labelAndOthers:Object = null;
         var dvo:Vo_unit = null;
         this.data = null;
         this.friendCombox.defaultText = "";
         var arr:Array = Model_Friends.friendArr.concat();
         var arr2:Array = Model_Friends.crossFriendArr.concat();
         for each(o in arr2)
         {
            arr.push(o);
         }
         src = [];
         pushFlag = true;
         for each(vo in arr)
         {
            if(vo.isOnline)
            {
               a = [vo.name,vo];
               src.push(a);
               if(vo.id == roleID)
               {
                  ddd = vo;
                  pushFlag = false;
               }
            }
         }
         if(!roleName && src.length == 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("29288",2));
            return;
         }
         if(Boolean(pushFlag) && Boolean(roleID) && Boolean(roleName))
         {
            others = {
               "name":roleName,
               "id":roleID
            };
            labelAndOthers = [roleName,others];
            src.unshift(labelAndOthers);
         }
         this.friendCombox.source = src;
         if(!this.isNiName)
         {
            if(Boolean(ddd))
            {
               this.friendCombox.select(ddd);
               this.data = {
                  "name":ddd.name,
                  "id":ddd.id
               };
            }
            else if(pushFlag && Boolean(others))
            {
               this.friendCombox.select(others);
            }
            else
            {
               dvo = arr[0];
               this.friendCombox.select(dvo);
               this.data = {
                  "name":dvo.name,
                  "id":dvo.id
               };
            }
         }
         this.isNiName = false;
         this.visible = true;
      }
      
      protected function get data() : Object
      {
         return this._data;
      }
      
      protected function set data(value:Object) : void
      {
         this._data = value;
      }
   }
}

