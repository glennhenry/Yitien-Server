package com.yiTian.view.modules.farm
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_farm;
   import com.yiTian.data.vo.Vo_farmList;
   import com.yiTian.gameUnit.magic.Effect;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.GameUnitManager;
   import com.yiTian.net.message.cg.FarmCGMessage;
   import com.yiTian.utils.Tween;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class View_farm_list extends Sprite
   {
      
      private var sp:Sprite;
      
      private var nowButton:Button;
      
      private var pageRight_Button:Button;
      
      private var pageLeft_Button:Button;
      
      private var right_Button:Button;
      
      private var left_Button:Button;
      
      private var page_text:MyTextField;
      
      public var Button_ShouQi:Button;
      
      public var Button_ZhanKai:Button;
      
      private var bitmap:Bitmap;
      
      public var jingJiChang:Button;
      
      public var introduce:MyTextField;
      
      private var _curPage:int = 1;
      
      private var _totalPage:int;
      
      private var shape:Shape;
      
      public var eff:Effect;
      
      public var isFirstOpen:Boolean = true;
      
      public function View_farm_list()
      {
         super();
         this.sp = new Sprite();
         addChild(this.sp);
         this.Button_ShouQi = ComponentUtil.getButton("","Button_ShouQi",this.sp,{
            "x":0,
            "y":110,
            "textColor":16184781
         },Global.ShanZhuang_Imgsdm);
         this.Button_ZhanKai = ComponentUtil.getButton("","Button_ZhanKai",this.sp,{
            "x":160,
            "y":110,
            "textColor":16184781
         },Global.ShanZhuang_Imgsdm);
         this.Button_ShouQi.visible = false;
         this.Button_ShouQi.addEventListener(MouseEvent.CLICK,this.farmListHandle);
         this.Button_ZhanKai.addEventListener(MouseEvent.CLICK,this.farmListHandle);
      }
      
      public function init() : void
      {
         ComponentUtil.getBitmap("Back_FriendList",this.sp,{
            "x":25,
            "y":0
         },Global.ShanZhuang_Imgsdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this.sp,{
            "x":84,
            "y":273,
            "width":48,
            "height":21
         },Global.Img_Cdm);
         this.page_text = ComponentUtil.getTextField("1/1",this.sp,{
            "x":95,
            "y":274,
            "color":14404503,
            "size":12,
            "leading":0
         });
         this.pageRight_Button = ComponentUtil.getButton("","Button_PageRight",this.sp,{
            "x":135,
            "y":273,
            "textColor":16184781
         },Global.Img_Cdm);
         this.pageLeft_Button = ComponentUtil.getButton("","Button_PageLeft",this.sp,{
            "x":60,
            "y":273,
            "textColor":16184781
         },Global.Img_Cdm);
         this.right_Button = ComponentUtil.getButton("","Button_NumMax",this.sp,{
            "x":159,
            "y":273,
            "textColor":16184781
         },Global.Img_Cdm);
         this.left_Button = ComponentUtil.getButton("","Button_NumMin",this.sp,{
            "x":35,
            "y":273,
            "textColor":16184781
         },Global.Img_Cdm);
         this.pageLeft_Button.name = "minus";
         this.pageRight_Button.name = "add";
         this.right_Button.name = "last";
         this.left_Button.name = "first";
         this.pageLeft_Button.addEventListener(MouseEvent.CLICK,this.pageChangeHandle);
         this.pageRight_Button.addEventListener(MouseEvent.CLICK,this.pageChangeHandle);
         this.right_Button.addEventListener(MouseEvent.CLICK,this.pageChangeHandle);
         this.left_Button.addEventListener(MouseEvent.CLICK,this.pageChangeHandle);
      }
      
      private function clickHandle(evt:MouseEvent) : void
      {
      }
      
      public function pageChangeHandle(e:MouseEvent) : void
      {
         var temBtn:Button = e.target as Button;
         if(temBtn.name == "first")
         {
            if(this._curPage == 1)
            {
               return;
            }
            this._curPage = 1;
         }
         else if(temBtn.name == "last")
         {
            if(this._curPage == this._totalPage)
            {
               return;
            }
            this._curPage = this._totalPage;
         }
         else if(temBtn.name == "add")
         {
            if(this._curPage == this._totalPage)
            {
               return;
            }
            ++this._curPage;
         }
         else
         {
            if(this._curPage == 1)
            {
               return;
            }
            --this._curPage;
         }
         this.update(this._curPage);
      }
      
      public function addItem(info:Vo_farmList) : void
      {
         var farmListItem:Child_farmListItem = null;
         farmListItem = Model_farm.instace.getFarmItem(info);
         farmListItem.x = 20;
         this.sp.addChild(farmListItem);
         Model_farm.instace.farm_friend_list.push(farmListItem);
      }
      
      public function updateFriend(id:int, status:int) : void
      {
         var i:int = 0;
         while(i < Model_farm.instace.farm_friend_list.length)
         {
            if(Model_farm.instace.farm_friend_list[i].vo_info.id == id)
            {
               Model_farm.instace.farm_friend_list[i].vo_info.status = status;
               Model_farm.instace.farm_friend_list[i].updateStatus(status);
            }
            i++;
         }
         this.update(this._curPage);
      }
      
      public function update(cup:int) : void
      {
         var i:int = 0;
         var temN:int = 0;
         var j:int = 0;
         var k:int = 0;
         while(k < Model_farm.instace.farm_friend_list.length)
         {
            Model_farm.instace.farm_friend_list[k].visible = false;
            k++;
         }
         if(!Model_farm.instace.farm_friend_list.length)
         {
            this.page_text.text = "1/1";
            return;
         }
         Model_farm.friendsPage = cup;
         if(Model_farm.instace.farm_friend_list.length % 10 == 0)
         {
            this._totalPage = Model_farm.instace.farm_friend_list.length / 10;
         }
         else
         {
            this._totalPage = Model_farm.instace.farm_friend_list.length / 10 + 1;
         }
         this._curPage = cup;
         this.page_text.text = String(this._curPage) + "/" + String(this._totalPage);
         if(this._curPage != this._totalPage)
         {
            i = 0;
            while(i < 10)
            {
               Model_farm.instace.farm_friend_list[i + (this._curPage - 1) * 10].visible = true;
               Model_farm.instace.farm_friend_list[i + (this._curPage - 1) * 10].y = 35 + i * 23;
               i++;
            }
         }
         else
         {
            temN = Model_farm.instace.farm_friend_list.length % 10 + 10 * int(Model_farm.instace.farm_friend_list.length % 10 == 0);
            j = 0;
            while(j < temN)
            {
               Model_farm.instace.farm_friend_list[j + (this._curPage - 1) * 10].y = 35 + j * 23;
               Model_farm.instace.farm_friend_list[j + (this._curPage - 1) * 10].visible = true;
               j++;
            }
         }
      }
      
      private function farmListHandle(evt:MouseEvent) : void
      {
         if(this.Button_ZhanKai.visible)
         {
            if(this.isFirstOpen)
            {
               this.init();
               this.shape = ComponentUtil.getShape(186,306,255,0);
               addChild(this.shape);
               this.sp.mask = this.shape;
               if(!Model_farm.instace.farm_friend_list)
               {
                  Model_farm.instace.farm_friend_list = new Array();
               }
               this.eff = EffectManager.addEffect("gridloading",this.sp,500,90,152,true);
               FarmCGMessage.cg_friends_list(1,GameUnitManager.hero.id);
               this.isFirstOpen = false;
            }
            Tween.to(this.sp,500,{"x":[138,0]});
            this.Button_ZhanKai.visible = false;
            this.Button_ShouQi.visible = true;
            this.update(this._curPage);
         }
         else
         {
            this.Button_ZhanKai.x = 0;
            Tween.to(this.sp,500,{"x":[0,162]});
            this.Button_ZhanKai.visible = true;
            this.Button_ShouQi.visible = false;
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
      }
   }
}

