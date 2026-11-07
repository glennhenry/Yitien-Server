package com.yiTian.view.modules.AiDeBaoBao
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.config.Enum_AiDeBaoBao;
   import com.yiTian.data.model.Model_heFu;
   import com.yiTian.net.message.cg.AiDeBaoBaoCGMessage;
   import com.yiTian.view.Panel;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.setTimeout;
   
   public class View_AiDeBaoBao_partnerMenu extends Panel
   {
      
      private static var _instance:View_AiDeBaoBao_partnerMenu;
      
      private var partnerArr:Array;
      
      private var listItemArr:Array;
      
      private var freshBtn:Button;
      
      private var curPage:int;
      
      private var totalPage:int;
      
      private var prevBtn:Button;
      
      private var nextBtn:Button;
      
      private var pageTxt:MyTextField;
      
      private var Kuang:ScaleBitmap;
      
      public function View_AiDeBaoBao_partnerMenu()
      {
         super();
         super.init();
      }
      
      public static function get instance() : View_AiDeBaoBao_partnerMenu
      {
         if(!_instance)
         {
            _instance = new View_AiDeBaoBao_partnerMenu();
         }
         return _instance;
      }
      
      override protected function initStaticView() : void
      {
         var i:int = 0;
         var item:ListItem = null;
         move = new Rectangle(40,32,425,30);
         ComponentUtil.getBitmap("Back_Seach",this,{
            "x":0,
            "y":0
         },Global.ADBB_Imgsdm);
         ComponentUtil.getBitmap("Back_Page",this,{
            "x":400,
            "y":396
         },Global.ADBB_Imgsdm);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":473,
            "y":48,
            "textColor":16184781
         },Global.ADBB_Imgsdm);
         ComponentUtil.getTextField("没有搭档不能进入场地哦！",this,{
            "x":53,
            "y":400,
            "color":65280,
            "size":14,
            "leading":0
         });
         this.Kuang = ComponentUtil.getScaleBitmap("Kuang",[20,10,10,10],this,{
            "x":410,
            "y":72,
            "width":76,
            "height":315
         },Global.ADBB_Imgsdm);
         this.Kuang.visible = false;
         this.freshBtn = ComponentUtil.getButton("","Button_Refresh",this,{
            "x":258,
            "y":389,
            "textColor":16184781
         },Global.ADBB_Imgsdm);
         this.freshBtn.callBack = function():void
         {
            AiDeBaoBaoCGMessage.CG_AiDeBaoBao_FRESH_LIST();
         };
         this.prevBtn = ComponentUtil.getButton("","Button_PageBack",this,{
            "x":371,
            "y":394,
            "textColor":16184781
         },Global.ADBB_Imgsdm);
         this.nextBtn = ComponentUtil.getButton("","Button_PageNext",this,{
            "x":463,
            "y":394,
            "textColor":16184781
         },Global.ADBB_Imgsdm);
         this.prevBtn.callBack = this.changePage;
         this.nextBtn.callBack = this.changePage;
         this.pageTxt = ComponentUtil.getTextField("1/1",this,{
            "x":429,
            "y":397,
            "color":16383744,
            "size":12,
            "leading":0
         },"center");
         this.curPage = 1;
         this.totalPage = 1;
         this.listItemArr = [];
         i = 0;
         while(i < 10)
         {
            item = new ListItem(i);
            item.x = 255;
            item.y = 77 + i * 31;
            addChild(item);
            item.visible = false;
            this.listItemArr.push(item);
            i++;
         }
         Global.control.registerCallBack(Enum_AiDeBaoBao.CLICK_YongBao,this.clickYongBao);
         Global.control.registerCallBack(Enum_AiDeBaoBao.CLICK_YongBao_CD_COMPLETE,this.clickYongBao_complete);
         Global.control.registerCallBack(Enum_AiDeBaoBao.GUIDE_Kuang_SHOW,this.showKuang);
      }
      
      private function showKuang(e:*) : void
      {
         Global.control.removeCallBack(Enum_AiDeBaoBao.GUIDE_Kuang_SHOW,this.showKuang);
         this.Kuang.visible = true;
         setTimeout(function():void
         {
            Kuang.visible = false;
         },Enum_AiDeBaoBao.GUIDE_SHOW_TIMES);
      }
      
      private function clickYongBao(e:int) : void
      {
         var i:* = undefined;
         var id:Number = Number(this.partnerArr[(this.curPage - 1) * 10 + e].id);
         var zoneId:Number = Number(this.partnerArr[(this.curPage - 1) * 10 + e].zoneId);
         AiDeBaoBaoCGMessage.CG_AiDeBaoBao_YongBao(id,zoneId);
         for(i in this.listItemArr)
         {
            this.listItemArr[i].setBtnCountDown();
         }
      }
      
      private function clickYongBao_complete(e:*) : void
      {
         var i:* = undefined;
         for(i in this.listItemArr)
         {
            this.listItemArr[i].setBtnCountDownComplete();
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            AiDeBaoBaoCGMessage.CG_AiDeBaoBao_FRESH_LIST();
         }
      }
      
      private function changePage(e:MouseEvent) : void
      {
         if(e.currentTarget == this.prevBtn)
         {
            --this.curPage;
         }
         else if(e.currentTarget == this.nextBtn)
         {
            ++this.curPage;
         }
         this.updateCurrentPage();
         this.updatePageTxt();
      }
      
      private function updateCurrentPage() : void
      {
         var obj:Object = null;
         var i:int = 0;
         while(i < 10)
         {
            if(Boolean(this.partnerArr[i + (this.curPage - 1) * 10]))
            {
               obj = this.partnerArr[i + (this.curPage - 1) * 10];
               this.listItemArr[i].visible = true;
               this.listItemArr[i].setName(Model_heFu.repNameUseSerID(obj.name + ".S" + obj.zoneId));
               this.listItemArr[i].setSex(obj.sex);
            }
            else
            {
               this.listItemArr[i].visible = false;
            }
            i++;
         }
      }
      
      private function updatePageTxt() : void
      {
         this.pageTxt.text = this.curPage + "/" + this.totalPage;
         if(this.curPage > 1)
         {
            this.prevBtn.enabled = true;
         }
         else
         {
            this.prevBtn.enabled = false;
         }
         if(this.curPage < this.totalPage)
         {
            this.nextBtn.enabled = true;
         }
         else
         {
            this.nextBtn.enabled = false;
         }
      }
      
      public function FreshPartnerList(arr:Array) : void
      {
         this.partnerArr = arr;
         this.totalPage = Math.max(Math.ceil(this.partnerArr.length / 10),1);
         this.curPage = 1;
         this.updateCurrentPage();
         this.updatePageTxt();
      }
      
      override public function resetPosition() : void
      {
         x = Global.stage.stageWidth - width;
         y = (Global.stage.stageHeight - height) / 2;
      }
   }
}

import com.ui.controls.Button;
import com.ui.controls.MyTextField;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.data.config.Enum_AiDeBaoBao;
import com.yiTian.scene.GameScene;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.utils.getTimer;

class ListItem extends Sprite
{
   
   public var id:int;
   
   private var nameTxt:MyTextField;
   
   private var sexTxt:MyTextField;
   
   private var btn:Button;
   
   private var time:int;
   
   private var beginTime:int;
   
   public function ListItem(id:int)
   {
      super();
      this.id = id;
      ComponentUtil.getBitmap("ADBB_Line",this,{
         "x":0,
         "y":26
      },Global.ADBB_Imgsdm);
      this.nameTxt = ComponentUtil.getTextField("",this,{
         "x":13,
         "y":2,
         "color":16776960,
         "size":12,
         "leading":0
      });
      this.sexTxt = ComponentUtil.getTextField("",this,{
         "x":120,
         "y":2,
         "color":65280,
         "size":12,
         "leading":0
      });
      this.btn = ComponentUtil.getButton("拥抱","Button_RedTwo",this,{
         "x":167,
         "y":0,
         "textColor":16184781
      },Global.Img_Cdm);
      this.btn.callBack = this.clickBtn;
   }
   
   public function setName(str:String) : void
   {
      this.nameTxt.text = str;
   }
   
   public function setSex(sex:int) : void
   {
      if(sex == 1)
      {
         this.sexTxt.text = "男";
      }
      else if(sex == 2)
      {
         this.sexTxt.text = "女";
      }
   }
   
   public function setBtnCountDown() : void
   {
      this.btn.enabled = false;
      this.beginTime = getTimer();
      this.time = 5000;
      GameScene.instance.addFrameCallBack(this.onFrame);
   }
   
   public function setBtnCountDownComplete() : void
   {
      this.btn.enabled = true;
      this.btn.label = "拥抱";
      GameScene.instance.removeFrameCallBack(this.onFrame);
   }
   
   private function onFrame() : void
   {
      var pastTime:int = getTimer() - this.beginTime;
      var nowTime:int = this.time - pastTime;
      if(nowTime > 0)
      {
         this.btn.label = String(int(nowTime / 1000));
      }
      else
      {
         GameScene.instance.removeFrameCallBack(this.onFrame);
         this.btn.label = "拥抱";
         this.btn.enabled = true;
      }
   }
   
   private function clickBtn(e:MouseEvent) : void
   {
      Global.control.sendNotification(Enum_AiDeBaoBao.CLICK_YongBao,this.id);
   }
}
