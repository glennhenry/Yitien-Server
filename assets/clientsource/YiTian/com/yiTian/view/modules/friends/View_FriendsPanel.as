package com.yiTian.view.modules.friends
{
   import com.ui.constants.ScrollAutoType;
   import com.ui.containers.Canvas;
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Const_strImg;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.data.vo.Vo_unit;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.Singleton;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Enum_explor;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.chat.ChatMediator;
   import com.yiTian.view.modules.loading.View_loading;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFieldType;
   import flash.text.TextFormat;
   
   public class View_FriendsPanel extends Panel
   {
      
      private var btn_Heat_List:Button;
      
      private var btn_QFriend_List:Button;
      
      private var btn_Contact_List:Button;
      
      private var SeachName_text:MyTextField;
      
      private var mtf_roleName:MyTextField;
      
      private var sp_head:Sprite;
      
      private var btn_friList:Button;
      
      private var btn_addFriend:Button;
      
      private var container:Canvas;
      
      private const itemOffsetX:Number = 16;
      
      private const itemOffsetY:Number = 22;
      
      private var dis1:DisplayObject;
      
      private var findFriendList:Child_searchFriend;
      
      private var p_contactParent:View_ItemParent;
      
      private var back:DisplayObjectContainer;
      
      private var bm_head:Bitmap;
      
      private var isFirstOpen:Boolean = true;
      
      private var isUIComplete:Boolean = false;
      
      private var medArr:Array = [];
      
      private var list:Array = [];
      
      private var c2:Sprite = new Sprite();
      
      private const MAX_CONTACT:int = 10;
      
      public function View_FriendsPanel()
      {
         super();
      }
      
      public static function setMarriageById(id:Number) : void
      {
         var array:Vector.<Child_FriendItem> = Model_Friends.viewItemVecArr[0].concat(Model_Friends.viewItemVecArr[1]);
         var i:int = 0;
         while(i < array.length)
         {
            if(array[i].vo_info.id == id)
            {
               array[i].setMarriage();
            }
            i++;
         }
         UIManager.friendPanel.bubbleSort(0);
         UIManager.friendPanel.resetAllPosition();
      }
      
      override protected function initStaticView() : void
      {
         var p_friendParent:View_ItemParent = null;
         var p_qFriendParent:View_ItemParent = null;
         var p_heatParent:View_ItemParent = null;
         var p_crossFriend:View_ItemParent = null;
         var p_crossHeatFriend:View_ItemParent = null;
         var head_rect:Bitmap = null;
         this.back = new Sprite();
         this.back.mouseEnabled = false;
         addChild(this.back);
         Model_Friends.dataArr = new Array();
         Model_Friends.viewItemVecArr = new Array(new Vector.<Child_FriendItem>(),new Vector.<Child_FriendItem>(),new Vector.<Child_FriendItem>(),new Vector.<Child_FriendItem>(),new Vector.<Child_FriendItem>());
         Model_Friends.isOpenArr = new Array();
         Model_Friends.parentArr = new Array();
         Model_Friends.dataArr.push();
         Model_Friends.dataArr[Model_Friends.FRIEND] = Model_Friends.friendArr;
         Model_Friends.dataArr[Model_Friends.QQFRIEND] = Model_Friends.qFriend;
         Model_Friends.dataArr[Model_Friends.HEAT] = Model_Friends.heatArr;
         Model_Friends.dataArr[Model_Friends.CROSS_FRIEND] = Model_Friends.crossFriendArr;
         Model_Friends.dataArr[Model_Friends.CROSS_HEAT] = Model_Friends.crossHeatArr;
         Model_Friends.isOpenArr.push(false,false,false,false,false,false);
         this.container = new Canvas(200,363);
         this.container.scrollAutoType = ScrollAutoType.REMAIN;
         this.container.y = 80;
         p_friendParent = new View_ItemParent();
         p_friendParent.label = this.convertText(LangConfig.getWord("23131",2),0,0);
         p_friendParent.x = 10;
         p_friendParent.y = 3;
         p_friendParent.addEventListener(MouseEvent.CLICK,this.RefreshFriendView);
         p_friendParent.disable();
         this.container.addChild(p_friendParent);
         p_qFriendParent = new View_ItemParent();
         p_qFriendParent.label = this.convertText(LangConfig.getWord("29236",2),0,0);
         p_qFriendParent.x = 10;
         p_qFriendParent.y = p_friendParent.y + p_friendParent.height + 3;
         p_qFriendParent.addEventListener(MouseEvent.CLICK,this.showQFriend);
         p_qFriendParent.disable();
         this.container.addChild(p_qFriendParent);
         p_heatParent = new View_ItemParent();
         p_heatParent.label = this.convertText(LangConfig.getWord("23132",2),0,0);
         p_heatParent.x = 10;
         p_heatParent.y = p_qFriendParent.y + p_qFriendParent.height + 3;
         p_heatParent.addEventListener(MouseEvent.CLICK,this.RefreshFriendView);
         p_heatParent.disable();
         this.container.addChild(p_heatParent);
         p_crossFriend = new View_ItemParent();
         p_crossFriend.label = this.convertText("跨服好友",0,0);
         p_crossFriend.x = 10;
         p_crossFriend.y = p_heatParent.y + p_heatParent.height + 3;
         p_crossFriend.addEventListener(MouseEvent.CLICK,this.RefreshFriendView);
         p_crossFriend.disable();
         this.container.addChild(p_crossFriend);
         p_crossHeatFriend = new View_ItemParent();
         p_crossHeatFriend.label = this.convertText("跨服黑名单",0,0);
         p_crossHeatFriend.x = 10;
         p_crossHeatFriend.y = p_crossFriend.y + p_crossFriend.height + 3;
         p_crossHeatFriend.addEventListener(MouseEvent.CLICK,this.RefreshFriendView);
         p_crossHeatFriend.disable();
         this.container.addChild(p_crossHeatFriend);
         this.p_contactParent = new View_ItemParent();
         this.p_contactParent.label = LangConfig.getWord("23133",2);
         this.p_contactParent.x = 10;
         this.p_contactParent.y = p_crossHeatFriend.y + p_crossHeatFriend.height + 3;
         this.p_contactParent.addEventListener(MouseEvent.CLICK,this.showContact);
         this.p_contactParent.disable();
         this.container.addChild(this.p_contactParent);
         this.SeachName_text = ComponentUtil.getTextField(LangConfig.getWord("23136",2),this,{
            "x":10,
            "y":60,
            "width":180,
            "realWidth":180
         });
         this.SeachName_text.maxChars = 10;
         this.SeachName_text.type = TextFieldType.INPUT;
         this.changeSigned(GameUnitManager.hero.signed);
         Model_Friends.parentArr.push(p_friendParent,p_qFriendParent,p_heatParent,p_crossFriend,p_crossHeatFriend,this.p_contactParent);
         this.mtf_roleName = ComponentUtil.getTextField(Model_heFu.repNameByHero(GameUnitManager.hero.name),this,{
            "x":58,
            "y":19.5
         });
         var str_icon:String = Const_strImg.getPlayerHead(GameUnitManager.hero.job,GameUnitManager.hero.sex,2);
         this.bm_head = Utils.getLoadBitmap(str_icon,this.bm_head,{
            "x":3,
            "y":3
         });
         head_rect = Utils.getLoadBitmap("resource/image/iconBg/grid_Skill_open.png",head_rect);
         this.sp_head = new Sprite();
         this.sp_head.y = 6;
         this.sp_head.x = 7;
         this.sp_head.addChild(head_rect);
         this.sp_head.addChild(this.bm_head);
         addChild(this.sp_head);
         var tf:TextFormat = new TextFormat();
         tf.size = 13;
         tf.color = 16043313;
         this.mtf_roleName.defaultTextFormat = tf;
         this.addChild(this.container);
         this.findFriendList = Child_searchFriend.instance;
         this.findFriendList.x = 16.75;
         this.findFriendList.y = 78.95;
         addChild(this.findFriendList);
         move = new Rectangle(0,0,205,54);
         CloseButton = ComponentUtil.getButton("","NPC_Close",this,{
            "x":175,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
      }
      
      public function updateMyHead(newSex:int, newName:String) : void
      {
         var str_icon:String = Const_strImg.getPlayerHead(GameUnitManager.hero.job,GameUnitManager.hero.sex,2);
         Utils.getLoadBitmap(str_icon,this.bm_head);
      }
      
      public function updateMyName(newName:String) : void
      {
         newName = Model_heFu.repNameByHero(newName);
         this.mtf_roleName.text = newName;
      }
      
      override protected function initDynamicView() : void
      {
         super.initDynamicView();
         this.SeachName_text.addEventListener(FocusEvent.FOCUS_IN,this.focusInHandle);
         this.SeachName_text.addEventListener(FocusEvent.FOCUS_OUT,this.focusOutHandle);
         this.SeachName_text.addEventListener(Event.CHANGE,this.changeHandle);
         addEventListener(MouseEvent.CLICK,this.clickHandle);
      }
      
      private function clickHandle(evt:MouseEvent = null) : void
      {
         this.findFriendList.hide();
      }
      
      private function changeHandle(evt:Event) : void
      {
         var vo:Vo_unit = null;
         if(this.SeachName_text.text == "")
         {
            return;
         }
         var voArr:Array = new Array();
         for each(vo in Model_Friends.friendArr)
         {
            if(this.test(vo.name,this.SeachName_text.text))
            {
               voArr.push(vo);
            }
         }
         if(voArr.length > 0)
         {
            this.findFriendList.show(voArr);
         }
         else
         {
            this.findFriendList.hide();
         }
         this.findFriendList.visible = voArr.length > 0;
      }
      
      private function test(allStr:String, testStr:String) : Boolean
      {
         if(testStr.length > allStr.length)
         {
            return false;
         }
         var index:int = 0;
         while(index < testStr.length)
         {
            if(testStr.charAt(index) != allStr.charAt(index))
            {
               return false;
            }
            index++;
         }
         return true;
      }
      
      private function focusInHandle(evt:FocusEvent) : void
      {
         if(this.SeachName_text.text == LangConfig.getWord("23136",2))
         {
            this.SeachName_text.text = "";
         }
      }
      
      private function focusOutHandle(evt:FocusEvent) : void
      {
         if(this.SeachName_text.text == "")
         {
            this.SeachName_text.text = LangConfig.getWord("23136",2);
         }
      }
      
      public function searchByName(str:String) : void
      {
         var fi:Child_FriendItem = null;
         for each(fi in Model_Friends.viewItemVecArr[Model_Friends.FRIEND])
         {
            if(fi.vo_info.name == str)
            {
               this.showItem(0);
               this.resetAllPosition();
               fi.choose();
            }
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         var arr:Array = null;
         View_FriendSelectedMenu.getInstance().visible = false;
         this.findFriendList.hide();
         if(value)
         {
            if(!this.isUIComplete)
            {
               if(!Global.FriendShip_Imgsdm)
               {
                  arr = [];
                  arr.push(["lang/ch/FriendShip_Imgs.swf",function(info:Object):void
                  {
                     Global.FriendShip_Imgsdm = info.applicationDomain;
                  },LangConfig.getWord("20000",2),Enum_loaderType.SINGLE,Enum_resType.RES_URL]);
                  View_loading.instance.load(arr,function():void
                  {
                     initTl();
                     visible = true;
                     View_loading.instance.visible = false;
                  });
                  return;
               }
               this.initTl();
               this.visible = true;
            }
            else
            {
               super.visible = true;
            }
            this.visHd();
         }
         else
         {
            super.visible = false;
         }
         if(value)
         {
            this.isFirstOpen = false;
            bind_target = Enum_explor.bind(Enum_explor.BTN_FRIEND);
            this.bubbleSort(0);
            this.resetAllPosition();
         }
      }
      
      private function visHd() : void
      {
         Child_FriendItem.doneSelectedTarget();
         this.showItem(0);
         this.resetAllPosition();
      }
      
      public function changeSigned(str:String) : void
      {
         if(str == "" || str == null)
         {
            str = "";
         }
      }
      
      private function questListClickHandle(evt:MouseEvent) : void
      {
         UIManager.friQuestPanel.visible = !UIManager.friQuestPanel.visible;
      }
      
      private function btn_addFriendClickHandle(evt:MouseEvent) : void
      {
         var pnl:View_AddContact = Singleton.getInstance(View_AddContact);
         if(pnl.visible == true)
         {
            pnl.visible = false;
         }
         else
         {
            pnl.show();
         }
      }
      
      public function updateLabelText() : void
      {
         Model_Friends.parentArr[Model_Friends.FRIEND].label = this.convertText(LangConfig.getWord("23131",2),Model_Friends.getOnLineLength(Model_Friends.FRIEND),Model_Friends.dataArr[Model_Friends.FRIEND].length);
         Model_Friends.parentArr[Model_Friends.QQFRIEND].label = this.convertText(LangConfig.getWord("29236",2),Model_Friends.getOnLineLength(Model_Friends.QQFRIEND),Model_Friends.dataArr[Model_Friends.QQFRIEND].length);
         Model_Friends.parentArr[Model_Friends.HEAT].label = this.convertText(LangConfig.getWord("23132",2),Model_Friends.getOnLineLength(Model_Friends.HEAT),Model_Friends.dataArr[Model_Friends.HEAT].length);
         Model_Friends.parentArr[Model_Friends.CROSS_FRIEND].label = this.convertText("跨服好友",Model_Friends.getOnLineLength(Model_Friends.CROSS_FRIEND),Model_Friends.dataArr[Model_Friends.CROSS_FRIEND].length);
         Model_Friends.parentArr[Model_Friends.CROSS_HEAT].label = this.convertText("跨服黑名单",Model_Friends.getOnLineLength(Model_Friends.CROSS_HEAT),Model_Friends.dataArr[Model_Friends.CROSS_HEAT].length);
      }
      
      override public function resetPosition() : void
      {
         x = Global.stage.stageWidth - 300;
         y = (Global.stage.stageHeight - height) / 2;
      }
      
      public function RefreshFriendView(evt:MouseEvent = null) : void
      {
         var index:int = Model_Friends.parentArr.indexOf(evt.target);
         Child_FriendItem.doneSelectedTarget();
         if(Model_Friends.isOpenArr[index] == false)
         {
            this.showItem(index);
         }
         else
         {
            this.hideItem(index);
         }
         this.resetAllPosition();
      }
      
      public function showItem(index:uint) : void
      {
         var fi:Child_FriendItem = null;
         for each(fi in Model_Friends.viewItemVecArr[index])
         {
            fi.visible = true;
         }
         Model_Friends.isOpenArr[index] = true;
         Model_Friends.parentArr[index].enable();
      }
      
      public function hideItem(index:uint) : void
      {
         var fi:Child_FriendItem = null;
         for each(fi in Model_Friends.viewItemVecArr[index])
         {
            fi.visible = false;
         }
         Model_Friends.isOpenArr[index] = false;
         Model_Friends.parentArr[index].disable();
      }
      
      public function addItemAt(info:Vo_unit, index:uint) : void
      {
         var fi:Child_FriendItem = new Child_FriendItem(info,Model_Friends.parentArr[index]);
         if(fi.isOnline())
         {
            Model_Friends.viewItemVecArr[index].unshift(fi);
         }
         else
         {
            Model_Friends.viewItemVecArr[index].push(fi);
         }
         fi.visible = Model_Friends.isOpenArr[index];
         if(info.isOnline == false)
         {
            fi.setOffLineType();
         }
         this.invalidate();
      }
      
      public function invalidate() : void
      {
         addEventListener(Event.EXIT_FRAME,this.updateLabelAndPos);
      }
      
      private function updateLabelAndPos(e:Event) : void
      {
         removeEventListener(Event.EXIT_FRAME,this.updateLabelAndPos);
         this.updateLabelText();
         this.resetAllPosition();
      }
      
      public function showQFriend(evt:MouseEvent = null) : void
      {
         Child_FriendItem.doneSelectedTarget();
         if(Model_Friends.isOpenArr[Model_Friends.QQFRIEND] == false)
         {
            this.showItem(Model_Friends.QQFRIEND);
         }
         else
         {
            this.hideItem(Model_Friends.QQFRIEND);
         }
         this.resetAllPosition();
      }
      
      public function showHeat(evt:MouseEvent = null) : void
      {
         var index:int = Model_Friends.parentArr.indexOf(evt.target);
         Child_FriendItem.doneSelectedTarget();
         if(Model_Friends.isOpenArr[index] == false)
         {
            this.showItem(index);
         }
         else
         {
            this.hideItem(index);
         }
         this.resetAllPosition();
      }
      
      public function showContact(evt:MouseEvent = null) : void
      {
         if(!this.p_contactParent.isEnabel)
         {
            this.p_contactParent.enable();
            if(!this.p_contactParent.contains(this.c2))
            {
               this.p_contactParent.addChild(this.c2);
            }
         }
         else
         {
            this.p_contactParent.disable();
            if(this.p_contactParent.contains(this.c2))
            {
               this.p_contactParent.removeChild(this.c2);
            }
         }
         this.container.align();
      }
      
      public function deleteChildByNameIndex(name:String, index:uint) : void
      {
         var fi:Child_FriendItem = null;
         var o:Child_FriendItem = null;
         for each(o in Model_Friends.viewItemVecArr[index])
         {
            if(name == o.vo_info.name)
            {
               fi = o;
               break;
            }
         }
         if(!fi)
         {
            return;
         }
         Model_Friends.viewItemVecArr[index].splice(Model_Friends.viewItemVecArr[index].indexOf(fi),1);
         if(Boolean(fi.parent))
         {
            fi.parent.removeChild(fi);
         }
         fi.dispose();
         this.invalidate();
      }
      
      private function convertText(t1:String, onLineCount:int, count:int) : String
      {
         return t1 + "[" + onLineCount.toString() + "/" + count.toString() + "]";
      }
      
      public function getFirstOffLineIndex(index:uint) : int
      {
         var i:uint = 0;
         while(i < Model_Friends.viewItemVecArr[index].length)
         {
            if(Model_Friends.viewItemVecArr[index][i].vo_info.isOnline == false)
            {
               return i;
            }
            i++;
         }
         return -1;
      }
      
      public function bubbleSort(index:uint) : void
      {
         var temp:Child_FriendItem = null;
         var j:uint = 0;
         var index1:int = 0;
         var index2:int = 0;
         var array:Vector.<Child_FriendItem> = Model_Friends.viewItemVecArr[index];
         var length:int = int(array.length);
         if(length <= 0)
         {
            return;
         }
         var i:uint = 0;
         while(i < length)
         {
            j = 0;
            while(j < length - 1)
            {
               if(array[j].vo_info.qinmidu < array[j + 1].vo_info.qinmidu)
               {
                  temp = array[j];
                  array[j] = array[j + 1];
                  array[j + 1] = temp;
               }
               j++;
            }
            i++;
         }
         i = 0;
         while(i < length)
         {
            j = 0;
            while(j < length - 1)
            {
               if(array[j].vo_info.isOnline < array[j + 1].vo_info.isOnline)
               {
                  temp = array[j];
                  array[j] = array[j + 1];
                  array[j + 1] = temp;
               }
               j++;
            }
            i++;
         }
         var search:Boolean = false;
         i = 0;
         while(i < length)
         {
            if(array[i].vo_info.id == GameUnitManager.hero.marriageID && array[i].vo_info.isOnline)
            {
               temp = array[i];
               array.splice(i,1);
               array.unshift(temp);
               search = true;
               return;
            }
            i++;
         }
         if(!search)
         {
            i = 0;
            while(i < length)
            {
               if(array[i].vo_info.isOnline == false)
               {
                  index1 = index1 <= i ? index1 : int(i);
               }
               if(array[i].vo_info.id == GameUnitManager.hero.marriageID)
               {
                  index2 = int(i);
               }
               i++;
            }
         }
         temp = array[index2];
         array.splice(index2,1);
         array.unshift(temp);
      }
      
      private function swapChild1(i:uint, j:uint, index:int) : void
      {
         var temp:Object = null;
         if(index < 0)
         {
            return;
         }
         temp = Model_Friends.viewItemVecArr[index][j];
         Model_Friends.viewItemVecArr[index][j] = Model_Friends.viewItemVecArr[index][i];
         Model_Friends.viewItemVecArr[index][i] = temp;
      }
      
      public function resetOffLineItemPos(fi:Child_FriendItem) : void
      {
         Model_Friends.viewItemVecArr.splice(Model_Friends.viewItemVecArr.indexOf(fi));
         Model_Friends.viewItemVecArr.push(fi);
      }
      
      public function resetOnLineItemPos(fi:Child_FriendItem) : void
      {
         Model_Friends.viewItemVecArr.splice(Model_Friends.viewItemVecArr.indexOf(fi));
         Model_Friends.viewItemVecArr.unshift(fi);
      }
      
      private function initTl() : void
      {
         this.isUIComplete = true;
         var back1:DisplayObject = ComponentUtil.getBitmap("Back_FriendList",this.back,{
            "x":0,
            "y":0
         },Global.FriendShip_Imgsdm);
         this.btn_addFriend = ComponentUtil.getButton("","Button_JoinFriend",this.back,{
            "x":118,
            "y":450,
            "textColor":16184781
         },Global.FriendShip_Imgsdm);
         this.btn_friList = ComponentUtil.getButton("","Button_JoinList",this,{
            "x":20,
            "y":450,
            "textColor":16184781
         },Global.FriendShip_Imgsdm);
         this.btn_addFriend.callBack = this.btn_addFriendClickHandle;
         this.btn_friList.callBack = this.questListClickHandle;
      }
      
      public function resetAllPosition() : void
      {
         var index:int = 0;
         var offsetYIndex:uint = 0;
         var fi:Child_FriendItem = null;
         offsetYIndex = 1;
         index = 0;
         while(index < Model_Friends.parentArr.length)
         {
            if(index > 0)
            {
               Model_Friends.parentArr[index].y = Model_Friends.parentArr[index - 1].y + offsetYIndex * this.itemOffsetY;
            }
            offsetYIndex = 1;
            for each(fi in Model_Friends.viewItemVecArr[index])
            {
               if(fi.visible == true)
               {
                  fi.y = Model_Friends.parentArr[index].y + offsetYIndex * this.itemOffsetY;
                  fi.x = this.itemOffsetX;
                  this.container.addChild(fi);
                  offsetYIndex += 1;
               }
            }
            index++;
         }
         this.container.align();
      }
      
      public function addContact(med:ChatMediator) : void
      {
         var tmp:Object = null;
         var index:int = this.medArr.indexOf(med);
         if(index >= 0)
         {
            tmp = this.medArr[0];
            this.medArr[0] = med;
            this.medArr[index] = tmp;
         }
         else
         {
            if(this.medArr.length >= this.MAX_CONTACT)
            {
               this.medArr.shift();
            }
            this.medArr.push(med);
         }
         this.p_contactParent.label = LangConfig.getWord("23133",2) + "[" + this.medArr.length.toString() + "/10]";
         this.updateC();
      }
      
      private function updateC() : void
      {
         var i:int = 0;
         var len:int = int(this.medArr.length);
         while(this.list.length < len)
         {
            this.list.push(contaceChild.pop());
         }
         i = 0;
         while(i < len)
         {
            this.list[i].med = this.medArr[i];
            this.list[i].x = 5;
            this.list[i].y = 20 + i * 20;
            this.c2.addChild(this.list[i]);
            i++;
         }
         this.container.align();
      }
   }
}

import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.data.Const_strImg;
import com.yiTian.utils.Utils;
import com.yiTian.view.modules.chat.ChatMediator;
import flash.display.Bitmap;
import flash.display.Shape;
import flash.display.Sprite;
import flash.events.MouseEvent;

class contaceChild extends Sprite
{
   
   private static const maskX:Number = 110;
   
   private static const maskY:Number = 20;
   
   private static var pool:Array = [];
   
   private var tf:MyTextField;
   
   private var _med:ChatMediator;
   
   private var bm_head:Bitmap;
   
   private var bg:Shape;
   
   private var isSelected:Boolean = false;
   
   public function contaceChild()
   {
      super();
      this.bg = new Shape();
      addChild(this.bg);
      this.bm_head = new Bitmap();
      var _temp_1:* = this.bm_head;
      this.bm_head.y = 2;
      _temp_1.x = 2;
      addChild(this.bm_head);
      this.tf = ComponentUtil.getTextField("",this,{"x":25});
      addEventListener(MouseEvent.CLICK,this.onClick);
      addEventListener(MouseEvent.ROLL_OVER,this.onOver);
      addEventListener(MouseEvent.ROLL_OUT,this.onOut);
   }
   
   public static function pop() : contaceChild
   {
      return Boolean(pool.length) ? pool.pop() : new contaceChild();
   }
   
   private function onClick(evt:MouseEvent) : void
   {
      evt.stopPropagation();
      this._med.state = ChatMediator.NONMSG;
      this._med.showPanel();
   }
   
   public function set selected(value:Boolean) : void
   {
      if(value == this.isSelected)
      {
         return;
      }
      if(value)
      {
      }
      this.isSelected = value;
   }
   
   public function get selected() : Boolean
   {
      return this.isSelected;
   }
   
   private function onOver(evt:MouseEvent) : void
   {
      if(!this.selected)
      {
         this.bg.graphics.beginFill(5609898,0.7);
         this.bg.graphics.drawRect(0,0,maskX,maskY);
         this.bg.graphics.endFill();
      }
   }
   
   private function onOut(evt:MouseEvent) : void
   {
      if(!this.selected)
      {
         this.bg.graphics.clear();
         this.bg.graphics.endFill();
      }
   }
   
   public function set med(vo:ChatMediator) : void
   {
      Utils.getLoadBitmap(Const_strImg.getPlayerHead(vo.roleJob,vo.roleSex,3),this.bm_head);
      this.tf.text = vo.roleName;
      this._med = vo;
   }
   
   public function dispose() : void
   {
      pool.push(this);
   }
}
