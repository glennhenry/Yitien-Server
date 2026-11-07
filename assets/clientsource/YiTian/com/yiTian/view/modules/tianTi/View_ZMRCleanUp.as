package com.yiTian.view.modules.tianTi
{
   import com.ui.constants.ScrollAutoType;
   import com.ui.containers.list.List;
   import com.ui.controls.Button;
   import com.ui.controls.CheckBox;
   import com.ui.controls.MyTextField;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.manager.EffectManager;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.ModalUIManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.TianTiCGMessage;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Tween;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   
   public class View_ZMRCleanUp extends Panel
   {
      
      private var bg:ScaleBitmap;
      
      private var nameList:List;
      
      private var infoList:List;
      
      private var btn:Button;
      
      private var checkBox:CheckBox;
      
      private var isInitB:Boolean = false;
      
      private var last:int = -2000;
      
      private var _lockCounter:int;
      
      private var bmTitle:Bitmap = new Bitmap();
      
      private var _nameListArr:Array;
      
      private var _infos:Array;
      
      private var viewInfos:Array = [];
      
      public function View_ZMRCleanUp()
      {
         super();
      }
      
      override protected function initStaticView() : void
      {
         bindParent = GameScene.modalLayer;
      }
      
      override protected function initDynamicView() : void
      {
      }
      
      private function initB() : void
      {
         if(this.isInitB)
         {
            return;
         }
         this.isInitB = true;
         this.bg = ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":608,
            "height":330
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back2",[5,5,10,10],this,{
            "x":24,
            "y":40,
            "width":560,
            "height":280
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":430,
            "y":60,
            "width":140,
            "height":180
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back_Num",[3,3,3,3],this,{
            "x":31,
            "y":48,
            "width":325,
            "height":264
         },Global.Img_Cdm);
         var tf_title1:MyTextField = ComponentUtil.getTextField(LangConfig.getWord("21018",2),this,{
            "x":369,
            "y":60,
            "color":11904647,
            "size":12,
            "leading":0
         });
         CloseButton = ComponentUtil.getButton("","Button_Close",this,{
            "x":574,
            "y":6,
            "textColor":16184781
         },Global.Img_Cdm);
         CloseButton.callBack = this.closeClickHd;
         this.nameList = new List(135,180,nameItem,null,List.TYPE_NO_STATE);
         ComponentUtil.setPropertie(this.nameList,{
            "x":435,
            "y":60
         });
         this.nameList.scrollAutoType = ScrollAutoType.TO_TOP;
         addChild(this.nameList);
         this.infoList = new List(315,250,infoItem,null,List.TYPE_NO_STATE);
         ComponentUtil.setPropertie(this.infoList,{
            "x":37,
            "y":57
         });
         addChild(this.infoList);
         this.checkBox = ComponentUtil.getCheckBox("","CheckBox",this,{
            "x":430,
            "y":252
         });
         this.checkBox.selected = true;
         this.checkBox.clickFun = this.checkBoxClickHd;
         this.checkBox.htmlText = "<font color=\'#dfba60\'>" + LangConfig.getWord("21060",2) + "</font>";
         this.btn = ComponentUtil.getButton(LangConfig.getWord("21019",2),"Button_Four",this,{
            "x":440,
            "y":282,
            "textColor":16184781
         },Global.Img_Cdm);
         this.btn.callBack = this.btnClickHd;
      }
      
      private function checkBoxClickHd(... param) : void
      {
         if(this._lockCounter > 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("21061",2));
            this.checkBox.selected = !this.checkBox.selected;
         }
      }
      
      private function btnClickHd(evt:MouseEvent) : void
      {
         var now:int = 0;
         if(this.btn.label == LangConfig.getWord("21019",2))
         {
            if(TianTiManager.curLv >= TianTiManager.recordLv)
            {
               UIManager.centerBroadcast.addMsg(LangConfig.getWord("29187",2));
               return;
            }
            now = getTimer();
            if(now - this.last >= 2000)
            {
               this.last = now;
               TianTiCGMessage.CG_TIANTIAUTOB(this.checkBox.selected ? 1 : 0);
            }
         }
         else if(this.btn.label == LangConfig.getWord("29225",2))
         {
            ModalUIManager.UNPOP();
            UIManager.tianTiPanel.visible = true;
         }
      }
      
      public function get lockCounter() : int
      {
         return this._lockCounter;
      }
      
      private function closeClickHd(evt:MouseEvent) : void
      {
         if(this._lockCounter > 0)
         {
            UIManager.centerBroadcast.addMsg(LangConfig.getWord("21061",2));
            return;
         }
         ModalUIManager.UNPOP();
      }
      
      override public function set visible(value:Boolean) : void
      {
         var ttPnl:View_tianTiPanel = null;
         if(value)
         {
            this.initB();
            this.viewInfos = [-1];
            this.infoList.source = this.viewInfos;
            ttPnl = UIManager.tianTiPanel;
            if(ttPnl.visible)
            {
               ttPnl.visible = false;
            }
            this.btn.label = LangConfig.getWord("21019",2);
            if(!this.bmTitle.bitmapData)
            {
               Utils.loadTitle("lang/ch/Challenge_Imgs.swf","Title_Challenge_Clean",this.bmTitle,{
                  "x":224,
                  "y":5
               },this);
            }
         }
         super.visible = value;
      }
      
      public function clearViewInfos() : void
      {
         this.viewInfos = [];
         this.infoList.source = this.viewInfos;
      }
      
      public function setNameListSrc(arr:Array) : void
      {
         this._nameListArr = arr;
         this.nameList.source = arr;
      }
      
      public function updateDefault() : void
      {
         var npcId:int = 0;
         var npcName:String = null;
         var rIndex:int = TianTiManager.recordLv;
         var curLv:int = TianTiManager.curLv;
         var arr:Array = [];
         var i:int = curLv + 1;
         while(i <= rIndex)
         {
            npcId = int(Data_lib.tianTi[i][0]);
            npcName = Data_lib.npc[npcId][0];
            arr.push({
               "name":npcName,
               "lv":i
            });
            i += 1;
         }
         this.setNameListSrc(arr);
      }
      
      public function updateInfo(infos:Array) : void
      {
         this._infos = infos;
         this.aniStep();
         this._lockCounter += 1;
         this.btn.enabled = false;
      }
      
      private function aniStep() : void
      {
         var arr:Object = null;
         var timeCost:int = 0;
         var lv:int = 0;
         var a1:Array = null;
         var type:int = 0;
         var num:int = 0;
         if(Boolean(this._infos.length))
         {
            arr = this._infos.shift();
            this.viewInfos.push(arr);
            this.infoList.source = this.viewInfos;
            if(arr is Array)
            {
               lv = int(arr[0]);
               timeCost = Enum_ZhangMenRen.SSPEED + Enum_ZhangMenRen.ASPEED * lv;
               for each(a1 in arr[1])
               {
                  type = int(a1[0]);
                  if(type == 5)
                  {
                     num = int(a1[2]);
                     EffectManager.flyEffGlobal(num);
                  }
               }
               if(Boolean(this._nameListArr.length))
               {
                  this._nameListArr.shift();
                  this.nameList.source = this._nameListArr;
               }
            }
            else
            {
               timeCost = Enum_ZhangMenRen.SSPEED;
            }
            Tween.to(this,timeCost,null,this.aniStep);
         }
         else
         {
            this._lockCounter -= 1;
            this.btn.enabled = true;
            this.btn.label = LangConfig.getWord("29225",2);
         }
      }
   }
}

import com.ui.containers.list.IListItem;
import com.ui.controls.MyTextField;
import com.ui.controls.ScaleBitmap;
import com.utils.ComponentUtil;
import com.yiTian.Global;
import com.yiTian.data.Data_lib;
import com.yiTian.manager.LangConfig;
import com.yiTian.net.handler.BagHandler;
import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
import flash.text.TextFieldAutoSize;

class infoItem extends IListItem
{
   
   private var tf:MyTextField;
   
   private var line:ScaleBitmap;
   
   private var _data:Object;
   
   public function infoItem()
   {
      super();
      this.tf = ComponentUtil.getTextField("",this,{
         "x":10,
         "realWidth":325,
         "leading":5,
         "wordWrap":true,
         "color":14662240,
         "realWidth":250
      });
      this.tf.multiline = true;
      this.line = ComponentUtil.getScaleBitmap("Line",[29,1,2,0],this,{
         "width":280,
         "height":2
      },Global.Img_Cdm);
   }
   
   override public function set data(value:Object) : void
   {
      var t:String = null;
      var estr:String = null;
      var itemInfo:Array = null;
      var type:int = 0;
      var id:int = 0;
      var num:int = 0;
      var itemStr:String = null;
      var arr:Array = null;
      var idd:int = 0;
      var colorLv:int = 0;
      var tmp:String = null;
      var tt:String = null;
      if(value is Array == false)
      {
         if(value == 0)
         {
            estr = LangConfig.getWord("29222",2);
            this.tf.align = TextFieldAutoSize.CENTER;
         }
         else if(value == 1)
         {
            estr = LangConfig.getWord("29223",2);
            BagHandler.getFullTis();
            this.tf.align = TextFieldAutoSize.CENTER;
         }
         else if(value == -1)
         {
            estr = LangConfig.getWord("29224",2);
            this.tf.align = TextFieldAutoSize.LEFT;
         }
         this.tf.htmlText = estr;
         this.line.visible = false;
         return;
      }
      this.tf.align = TextFieldAutoSize.LEFT;
      var data:Array = value as Array;
      var lv:int = int(data[0]);
      var itemInfos:Array = data[1];
      var jydType:int = int(data[2]);
      var str:String = "";
      var npcName:String = Data_lib.npc[Data_lib.tianTi[lv][0]][0];
      var lvStr:String = "<font size=\'14\'><b>" + LangConfig.getWord("29210",2,lv.toString(),npcName) + "</b></font>";
      var strArr:Array = [];
      var itemRecordArr:Array = [];
      var i:int = 0;
      while(i < itemInfos.length)
      {
         itemInfo = itemInfos[i];
         type = int(itemInfo[0]);
         id = int(itemInfo[1]);
         num = int(itemInfo[2]);
         if(num > 0)
         {
            if(type == 1)
            {
               itemRecordArr.push(Enum_BroadCastTool.instance.getItemText(id));
            }
            else if(type == 2)
            {
               itemRecordArr.push(Enum_BroadCastTool.instance.getEquipText(id));
            }
            else if(type == 5)
            {
               itemStr = "<font color=\'#80bd64\'>" + LangConfig.getWord("29215",2).replace("&va","") + num.toString() + "</font>";
               arr = [838,831,832,833,834,0,25,50,75,100];
               if(jydType > 0)
               {
                  itemStr += "   （" + LangConfig.getWord(arr[jydType],0) + LangConfig.getWord("837",0) + (100 + arr[5 + jydType]).toString() + "%）";
               }
               else
               {
                  itemStr += "   " + LangConfig.getWord("838",0);
               }
               itemStr = Enum_BroadCastTool.instance.getColorStr(itemStr,jydType);
               strArr.push(itemStr);
            }
            else
            {
               idd = 29210 + type;
               colorLv = -1;
               switch(type)
               {
                  case 10:
                     colorLv = 2;
                     break;
                  case 9:
                     colorLv = 4;
               }
               if(colorLv != -1)
               {
                  itemStr = Enum_BroadCastTool.instance.getColorStr(LangConfig.getWord(idd.toString(),2).replace("&va",num.toString()),colorLv);
               }
               else
               {
                  itemStr = "<font color=\'#f9ff00\'>" + LangConfig.getWord(idd.toString(),2).replace("&va",num.toString()) + "</font>";
               }
               strArr.push(itemStr);
            }
         }
         i += 1;
      }
      str = lvStr;
      for each(t in strArr)
      {
         str += "\n   " + t;
      }
      if(Boolean(itemRecordArr.length))
      {
         tmp = "\n   " + LangConfig.getWord("29221",2);
         for each(tt in itemRecordArr)
         {
            tmp += "  " + tt;
         }
         str += tmp;
      }
      this._data = value;
      this.tf.htmlText = str;
      this.line.y = this.tf.height + 3;
      this.line.visible = true;
   }
   
   override public function get height() : Number
   {
      if(Boolean(this._data) && this._data is Array)
      {
         return super.height + 8;
      }
      return super.height;
   }
   
   override public function dispose() : void
   {
      this._data = null;
      this.tf.text = "";
      this.line.y = 0;
      this.line.visible = false;
   }
}

class nameItem extends IListItem
{
   
   private var nameTf:MyTextField;
   
   private var _data:Object;
   
   public function nameItem()
   {
      super();
      this.nameTf = ComponentUtil.getTextField("",this,{"color":14662240});
   }
   
   override public function set data(value:Object) : void
   {
      this._data = value;
      var name:String = this._data.name;
      var lv:int = int(this._data.lv);
      this.nameTf.htmlText = name;
   }
   
   override public function dispose() : void
   {
      this.nameTf.text = "";
      this._data = null;
   }
}
