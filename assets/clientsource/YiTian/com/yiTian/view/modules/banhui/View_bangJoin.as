package com.yiTian.view.modules.banhui
{
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.vo.Vo_party_apply_list;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.view.Panel;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.text.TextFormatAlign;
   
   public class View_bangJoin extends Panel
   {
      
      public static var dataArr:Array = [];
      
      private static var isFirstOpen:Boolean = true;
      
      private var totalAg:Button;
      
      private var totalNo:Button;
      
      private var minuBtn:Button;
      
      private var riseBtn:Button;
      
      private var pageTF:MyTextField;
      
      private var back:DisplayObject;
      
      private var desArr:Array;
      
      private var psArr:Array = [60,172,267,409];
      
      private var curPage:int = 1;
      
      private var totalPage:int;
      
      private var leftNumPage:int;
      
      private var i:int;
      
      private var itemArr:Vector.<JoinItem> = new Vector.<JoinItem>();
      
      public function View_bangJoin()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         this.desArr = [LangConfig.getWord("60021",6),LangConfig.getWord("60004",6),LangConfig.getWord("60022",6),LangConfig.getWord("60023",6)];
         var back1:ScaleBitmap = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":530,
            "height":432
         },Global.Img_Cdm);
         var back2:ScaleBitmap = ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":482,
            "height":382
         },Global.Img_Cdm);
         var back3:ScaleBitmap = ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":30,
            "y":48,
            "width":470,
            "height":342
         },Global.Img_Cdm);
         var back4:ScaleBitmap = ComponentUtil.getScaleBitmap("Back_Title",[2,2,18,18],this,{
            "x":32,
            "y":50,
            "width":466,
            "height":20
         },Global.Img_Cdm);
         var back5:ScaleBitmap = ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":222,
            "y":394,
            "width":100,
            "height":20
         },Global.Img_Cdm);
         move = new Rectangle(0,0,428,38);
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":492,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         var i:int = 0;
         while(i < 4)
         {
            ComponentUtil.getTextField(this.desArr[i],this,{
               "x":this.psArr[i],
               "y":50
            });
            i++;
         }
         this.totalAg = ComponentUtil.getButton(LangConfig.getWord("29171",2),"Button_Four",this,{
            "x":275,
            "y":353
         },Global.Img_Cdm);
         this.totalNo = ComponentUtil.getButton(LangConfig.getWord("29172",2),"Button_Four",this,{
            "x":350,
            "y":353
         },Global.Img_Cdm);
         this.totalAg.visible = false;
         this.totalNo.visible = false;
         this.riseBtn = ComponentUtil.getButton("","Button_PageRight",this,{
            "x":325,
            "y":394,
            "textColor":16184781,
            "name":"rise"
         },Global.Img_Cdm);
         this.minuBtn = ComponentUtil.getButton("","Button_PageLeft",this,{
            "x":198,
            "y":394,
            "textColor":16184781,
            "name":"minus"
         },Global.Img_Cdm);
         this.minuBtn.addEventListener(MouseEvent.CLICK,this.pageHandle);
         this.riseBtn.addEventListener(MouseEvent.CLICK,this.pageHandle);
         this.pageTF = ComponentUtil.getTextField("0000/0000",this,{
            "x":241,
            "y":394,
            "color":16777215,
            "size":12,
            "leading":0,
            "realWidth":64
         });
         this.pageTF.align = TextFormatAlign.CENTER;
         this.addItem();
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            if(isFirstOpen)
            {
               isFirstOpen = false;
               ComponentUtil.getBitmap("Title_BangJoin",this,{
                  "x":185,
                  "y":5
               },Global.Bang_Imgsdm);
            }
            this.updataTotal();
            this.updataItem(1);
         }
         else
         {
            this.curPage = 1;
            this.pageTF.text = this.curPage + "/" + this.totalPage;
         }
      }
      
      public function updataTotal() : void
      {
         this.totalPage = Math.ceil(dataArr.length / 10);
         if(dataArr.length == 0)
         {
            this.curPage = 1;
            this.totalPage = 1;
            this.pageTF.text = this.curPage + "/" + this.totalPage;
            return;
         }
         this.leftNumPage = int(dataArr.length % 10);
         if(this.leftNumPage == 0)
         {
            this.leftNumPage = 10;
         }
         if(this.curPage < 1)
         {
            this.curPage = 1;
         }
         if(this.totalPage < 1)
         {
            this.totalPage = 1;
         }
      }
      
      public function updataItem(page:int) : void
      {
         if(!dataArr.length)
         {
            return;
         }
         this.hide();
         this.show(page == this.totalPage ? this.leftNumPage : 10);
      }
      
      public function get cur_page() : int
      {
         return this.curPage;
      }
      
      public function resize() : void
      {
         this.updataTotal();
         this.updataItem(this.curPage);
      }
      
      private function show(visLen:int) : void
      {
         var temItem:JoinItem = null;
         var apply_vo:Vo_party_apply_list = null;
         this.pageTF.text = this.curPage + "/" + this.totalPage;
         this.i = 0;
         while(this.i < visLen)
         {
            temItem = this.itemArr[this.i];
            apply_vo = dataArr[this.i + (this.curPage - 1) * 10];
            temItem.visible = true;
            trace(dataArr[this.i]);
            temItem.updata(apply_vo);
            ++this.i;
         }
      }
      
      private function pageHandle(e:MouseEvent) : void
      {
         var typeName:String = (e.target as Button).name;
         if(typeName == "minus")
         {
            if(this.curPage == 1)
            {
               return;
            }
            --this.curPage;
         }
         else
         {
            if(this.curPage == this.totalPage)
            {
               return;
            }
            ++this.curPage;
         }
         this.updataItem(this.curPage);
      }
      
      private function getInstance() : void
      {
         var apply_vo:Vo_party_apply_list = null;
         var apllyItem_arr:Array = null;
         dataArr = [];
         var i:int = 0;
         while(i < 5)
         {
            apllyItem_arr = [];
            apllyItem_arr.push(i,"",i,3);
            apply_vo = new Vo_party_apply_list();
            apply_vo.init(apllyItem_arr);
            dataArr.push(apply_vo);
            i++;
         }
      }
      
      private function hide() : void
      {
         this.i = 0;
         while(this.i < 10)
         {
            this.itemArr[this.i].visible = false;
            ++this.i;
         }
      }
      
      override public function resetPosition() : void
      {
         x = (Global.stage.stageWidth - 527) / 2;
         y = (Global.stage.stageHeight - 427) / 2;
      }
      
      private function addItem() : void
      {
         var temItem:JoinItem = null;
         var i:int = 0;
         i = 0;
         while(i < 10)
         {
            temItem = new JoinItem();
            addChild(temItem);
            temItem.x = 32;
            temItem.y = 70 + i * 32;
            temItem.visible = false;
            this.itemArr.push(temItem);
            i++;
         }
      }
   }
}

import com.ui.controls.Button;
import com.ui.controls.MyTextField;
import com.ui.controls.ScaleBitmap;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.command.Enum_MsgType;
import com.yiTian.data.config.Enum_job;
import com.yiTian.data.model.Model_bang;
import com.yiTian.data.model.Model_heFu;
import com.yiTian.data.model.Model_shenshou;
import com.yiTian.data.vo.Vo_party_apply_list;
import com.yiTian.manager.LangConfig;
import com.yiTian.manager.UIManager;
import com.yiTian.net.message.cg.BangCGMessage;
import com.yiTian.view.modules.banhui.View_bangJoin;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.events.TextEvent;
import flash.text.TextFormatAlign;

class JoinItem extends Sprite
{
   
   private var nameTF:MyTextField;
   
   private var lvlTF:MyTextField;
   
   private var jobTF:MyTextField;
   
   private var agredBtn:Button;
   
   private var cancedBtn:Button;
   
   private var roleId:Number;
   
   public function JoinItem()
   {
      super();
      var back1:ScaleBitmap = ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
         "x":0,
         "y":29,
         "width":461,
         "height":2
      },Global.Img_Cdm);
      this.nameTF = ComponentUtil.getTextField("",this,{
         "x":5,
         "y":9,
         "color":11904647,
         "size":12,
         "leading":0
      });
      this.lvlTF = ComponentUtil.getTextField("",this,{
         "x":142,
         "y":9,
         "color":11904647,
         "size":12,
         "leading":0
      });
      this.jobTF = ComponentUtil.getTextField("",this,{
         "x":228,
         "y":9,
         "color":11904647,
         "size":12,
         "leading":0
      });
      this.nameTF.align = TextFormatAlign.CENTER;
      this.nameTF.mouseEnabled = true;
      this.lvlTF.align = TextFormatAlign.CENTER;
      this.jobTF.align = TextFormatAlign.CENTER;
      this.agredBtn = ComponentUtil.getButton(LangConfig.getWord("29031",2),"Button_Two",this,{
         "x":329,
         "y":5,
         "textColor":16184781
      },Global.Img_Cdm);
      this.cancedBtn = ComponentUtil.getButton(LangConfig.getWord("29032",2),"Button_Two",this,{
         "x":406,
         "y":5,
         "textColor":16184781
      },Global.Img_Cdm);
      this.agredBtn.callBack = this.operHandle;
      this.cancedBtn.callBack = this.operHandle;
   }
   
   public function set enable(value:Boolean) : void
   {
      this.agredBtn.enabled = value;
      this.cancedBtn.enabled = value;
   }
   
   private function operHandle(e:MouseEvent) : void
   {
      if(Model_shenshou.challBoo == 3)
      {
         UIManager.centerBroadcast.addMsg(LangConfig.getWord("30077",3));
         return;
      }
      var str:String = (e.target as Button).label;
      BangCGMessage.CG_BANG_APPLY_N(this.roleId,str == LangConfig.getWord("29031",2) ? 1 : 2);
      visible = false;
      this.removeItem();
      UIManager.bangJoinList.resize();
   }
   
   private function removeItem() : void
   {
      var i:int = 0;
      while(i < View_bangJoin.dataArr.length)
      {
         if(this.roleId == View_bangJoin.dataArr[i].apply_id)
         {
            View_bangJoin.dataArr.splice(i,1);
            return;
         }
         i++;
      }
   }
   
   private function linkHandle(e:TextEvent) : void
   {
      Global.control.sendNotification(Enum_MsgType.MSG_CHECKOTHERROLE,this.roleId);
   }
   
   public function updata(voApp:Vo_party_apply_list) : void
   {
      this.roleId = voApp.apply_id;
      this.nameTF.htmlText = "<u>" + "<a href=\'event:" + String(this.roleId) + "\'>" + Model_heFu.repName(voApp.name) + "</a>" + "</u>";
      this.nameTF.addEventListener(TextEvent.LINK,this.linkHandle);
      this.lvlTF.text = String(voApp.level);
      this.jobTF.htmlText = Enum_job.getMenPai(voApp.job);
      if(Boolean(Model_bang.partyInfo))
      {
         if(Model_bang.partyInfo.party_position <= Model_bang.ZHANGLAO)
         {
            this.enable = true;
         }
         else
         {
            this.enable = false;
         }
      }
   }
}
