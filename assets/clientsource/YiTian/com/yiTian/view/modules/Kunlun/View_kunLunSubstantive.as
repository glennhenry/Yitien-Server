package com.yiTian.view.modules.Kunlun
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_loaderType;
   import com.yiTian.data.config.Enum_resType;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.net.message.cg.KLMountianCGMessage;
   import com.yiTian.view.Panel;
   import com.yiTian.view.modules.loading.View_loading;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFormatAlign;
   
   public class View_kunLunSubstantive extends Panel
   {
      
      private static const MAX_NUM:int = 10;
      
      private var bg:DisplayObjectContainer;
      
      private var itemVec:Array;
      
      public var Button_Page_Back:Button;
      
      public var Button_Page_Next:Button;
      
      public var Total_text:MyTextField;
      
      public var Page_text:MyTextField;
      
      public var _totalPage:int;
      
      public var _curPage:int = 1;
      
      private var Y1:Number = 69;
      
      private var offsetY:Number = 26;
      
      private var X1:Number = 37;
      
      private var data:Array = [];
      
      private var isUIComplete:Boolean = false;
      
      public function View_kunLunSubstantive()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         var tf:MyTextField = null;
         this.bg = new Sprite();
         this.bg.mouseChildren = false;
         addChild(this.bg);
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this.bg,{
            "x":0,
            "y":0,
            "width":318,
            "height":383
         },Global.Img_Cdm);
         move = new Rectangle(0,0,this.bg.width,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":286,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":115,
            "y":340,
            "width":88,
            "height":20
         },Global.Img_Cdm);
         var arr:Array = [0,65,LangConfig.getWord("29105",2),90,120,LangConfig.getWord("29106",2),185,65,LangConfig.getWord("29107",2)];
         var i:int = 0;
         while(i < 3)
         {
            tf = ComponentUtil.getTextField("",this,{
               "x":arr[i * 3] + 43,
               "y":42,
               "realWidth":arr[i * 3 + 1],
               "color":10338946
            });
            tf.text = arr[i * 3 + 2];
            i += 1;
         }
         this.Button_Page_Back = ComponentUtil.getButton("","Button_PageLeft",this,{
            "x":95,
            "y":340,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Button_Page_Next = ComponentUtil.getButton("","Button_PageRight",this,{
            "x":200,
            "y":340,
            "textColor":16184781
         },Global.Img_Cdm);
         this.Page_text = ComponentUtil.getTextField("000/000",this,{
            "x":134,
            "y":341,
            "color":14662240,
            "size":12,
            "leading":0,
            "realWidth":45
         });
         this.Page_text.align = TextFormatAlign.CENTER;
         this.Button_Page_Next.name = "next";
         this.Button_Page_Back.name = "back";
         this.Button_Page_Next.callBack = this.Button_Page_Back.callBack = this.nextHandle;
      }
      
      override protected function initDynamicView() : void
      {
         this.itemVec = [];
         super.initDynamicView();
      }
      
      public function update(arr:Array) : void
      {
         this.data = [];
         var i:int = 0;
         while(i < arr.length)
         {
            if(Boolean(arr[i]) && arr[i][3] > 0)
            {
               this.data.push(arr[i]);
            }
            i++;
         }
         this.showData(0);
         this._curPage = 1;
         this.Page_text.text = String(this._curPage) + "/" + String(this._totalPage);
      }
      
      public function showData(curPage:int) : void
      {
         var i:int = 0;
         var it:Item = null;
         var currentIndex:int = MAX_NUM * curPage;
         var totalLen:int = int(this.data.length);
         var showNum:int = totalLen - currentIndex > MAX_NUM ? MAX_NUM : int(totalLen - currentIndex);
         this._totalPage = totalLen % MAX_NUM == 0 ? int(totalLen / MAX_NUM) : int(int(totalLen / MAX_NUM) + 1);
         i = 0;
         while(i < MAX_NUM)
         {
            if(!this.itemVec[i])
            {
               it = new Item();
               it.x = this.X1;
               it.y = this.Y1 + this.offsetY * i;
               addChild(it);
               this.itemVec.push(it);
            }
            if(Boolean(this.data[currentIndex]) && i < showNum)
            {
               this.itemVec[i].visible = true;
               this.itemVec[i].obj = this.data[currentIndex];
               this.itemVec[i].rank = currentIndex + 1;
            }
            else
            {
               this.itemVec[i].visible = false;
            }
            currentIndex++;
            i += 1;
         }
      }
      
      private function nextHandle(e:MouseEvent) : void
      {
         if(e.target.name == "next")
         {
            if(this._curPage < this._totalPage)
            {
               if(this._curPage == this._totalPage)
               {
                  return;
               }
               ++this._curPage;
               this.Page_text.text = String(this._curPage) + "/" + String(this._totalPage);
            }
         }
         else if(e.target.name == "back")
         {
            if(this._curPage == 1)
            {
               return;
            }
            if(this._curPage > 1)
            {
               --this._curPage;
               this.Page_text.text = String(this._curPage) + "/" + String(this._totalPage);
            }
         }
         this.showData(this._curPage - 1);
      }
      
      override public function set visible(value:Boolean) : void
      {
         var arr:Array = null;
         if(value)
         {
            if(!this.isUIComplete)
            {
               if(!Global.KunLun_Imgsdm)
               {
                  arr = [];
                  arr.push(["lang/ch/KunLun_Imgs.swf",function(info:Object):void
                  {
                     Global.KunLun_Imgsdm = info.applicationDomain;
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
            KLMountianCGMessage.CG_KL_RANK1();
         }
         super.visible = value;
      }
      
      private function initT() : void
      {
         this.isUIComplete = true;
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this.bg,{
            "x":24,
            "y":40,
            "width":270,
            "height":328
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this.bg,{
            "x":25,
            "y":41,
            "width":268,
            "height":22
         },Global.Img_Cdm);
         ComponentUtil.getBitmap("Title_KLPaiHang",this.bg,{
            "x":74,
            "y":5
         },Global.KunLun_Imgsdm);
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - width) / 2;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.command.Enum_MsgType;
import com.yiTian.data.config.Enum_job;
import com.yiTian.data.model.Model_heFu;
import com.yiTian.utils.HtmlUtil;
import flash.display.Sprite;
import flash.events.TextEvent;
import flash.text.TextFieldAutoSize;

class Item extends Sprite
{
   
   private static var offset1:Number = 65;
   
   private var tf_rank:MyTextField;
   
   private var tf_name:MyTextField;
   
   private var tf_sc:MyTextField;
   
   private var role_id:Number;
   
   public function Item()
   {
      super();
      this.tf_rank = ComponentUtil.getTextField("",this,{
         "x":0,
         "realWidth":offset1,
         "color":14540032
      });
      this.tf_rank.autoSize = TextFieldAutoSize.CENTER;
      this.tf_name = ComponentUtil.getTextField("",this,{
         "x":offset1,
         "realWidth":120
      });
      this.tf_name.autoSize = TextFieldAutoSize.CENTER;
      this.tf_name.mouseEnabled = true;
      this.tf_name.addEventListener(TextEvent.LINK,this.linkHd);
      this.tf_sc = ComponentUtil.getTextField("",this,{
         "x":offset1 + 120,
         "realWidth":offset1,
         "color":14483456
      });
      this.tf_sc.autoSize = TextFieldAutoSize.CENTER;
      ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
         "x":0,
         "y":23,
         "width":250,
         "height":2
      },Global.Img_Cdm);
   }
   
   public function set rank(value:int) : void
   {
      this.tf_rank.text = value.toString();
   }
   
   private function linkHd(evt:TextEvent) : void
   {
      Global.control.sendNotification(Enum_MsgType.MSG_CHECKOTHERROLE,this.role_id);
   }
   
   public function set obj(value:Object) : void
   {
      this.role_id = value[0];
      var roleName:String = Model_heFu.repNameByHero(value[1]);
      var job:int = int(value[2]);
      var soccer:int = int(value[3]);
      this.tf_name.htmlText = HtmlUtil.createLink(HtmlUtil.fontNoSize(roleName,"#" + Enum_job.JOBCOLOR[job - 1]));
      this.tf_sc.text = soccer.toString();
   }
}
