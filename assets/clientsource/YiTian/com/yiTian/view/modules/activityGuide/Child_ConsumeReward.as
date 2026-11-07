package com.yiTian.view.modules.activityGuide
{
   import com.ui.controls.MaskProgressBar;
   import com.ui.controls.MyTextField;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.data.Data_lib;
   import com.yiTian.data.config.DictionaryTabel;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.utils.Tween;
   import com.yiTian.view.modules.broadcast.Enum_BroadCastTool;
   import flash.display.Sprite;
   import flash.text.TextFieldAutoSize;
   
   public class Child_ConsumeReward extends Sprite
   {
      
      private var _tfMain:MyTextField;
      
      private var _processBar:MaskProgressBar;
      
      private var _tfBarValue:MyTextField;
      
      private var _tfDate0:MyTextField;
      
      private var _tfDate1:MyTextField;
      
      private var _tfDate2:MyTextField;
      
      private var _tfDate3:MyTextField;
      
      private var _tfDate4:MyTextField;
      
      private var gridIsInit:Boolean = false;
      
      private var gridArray:Array;
      
      public function Child_ConsumeReward()
      {
         super();
         this.init();
      }
      
      public function init() : void
      {
         this.biubiubiu(Data_lib.czfl.toArray());
         ComponentUtil.getScaleBitmap("Line_Shu",[0,1,0,1],this,{
            "x":2,
            "y":2,
            "width":1,
            "height":130
         },Global.WuYue_Imgsdm);
         ComponentUtil.getScaleBitmap("Line_Shu",[0,1,0,1],this,{
            "x":114,
            "y":2,
            "width":1,
            "height":130
         },Global.WuYue_Imgsdm);
         ComponentUtil.getScaleBitmap("Line_Shu",[0,1,0,1],this,{
            "x":114 + 66 * 3,
            "y":2,
            "width":1,
            "height":130
         },Global.WuYue_Imgsdm);
         ComponentUtil.getScaleBitmap("Line_Shu",[0,1,0,1],this,{
            "x":114 + 66,
            "y":2,
            "width":1,
            "height":130
         },Global.WuYue_Imgsdm);
         ComponentUtil.getScaleBitmap("Line_Shu",[0,1,0,1],this,{
            "x":114 + 66 * 2,
            "y":2,
            "width":1,
            "height":130
         },Global.WuYue_Imgsdm);
         ComponentUtil.getScaleBitmap("Line_Shu",[0,1,0,1],this,{
            "x":114 + 66 * 4,
            "y":2,
            "width":1,
            "height":130
         },Global.WuYue_Imgsdm);
         ComponentUtil.getScaleBitmap("Line_Shu",[0,1,0,1],this,{
            "x":114 + 66 * 5,
            "y":2,
            "width":1,
            "height":130
         },Global.WuYue_Imgsdm);
         ComponentUtil.getScaleBitmap("Line_Heng",[1,0,1,0],this,{
            "x":2,
            "y":2,
            "width":442,
            "height":1
         },Global.WuYue_Imgsdm);
         ComponentUtil.getScaleBitmap("Line_Heng",[1,0,1,0],this,{
            "x":2,
            "y":28,
            "width":442,
            "height":1
         },Global.WuYue_Imgsdm);
         ComponentUtil.getScaleBitmap("Line_Heng",[1,0,1,0],this,{
            "x":53,
            "y":80,
            "width":392,
            "height":1
         },Global.WuYue_Imgsdm);
         ComponentUtil.getScaleBitmap("Line_Heng",[1,0,1,0],this,{
            "x":2,
            "y":54,
            "width":442,
            "height":1
         },Global.WuYue_Imgsdm);
         ComponentUtil.getScaleBitmap("Line_Heng",[1,0,1,0],this,{
            "x":53,
            "y":106,
            "width":392,
            "height":1
         },Global.WuYue_Imgsdm);
         ComponentUtil.getScaleBitmap("Line_Heng",[1,0,1,0],this,{
            "x":2,
            "y":132,
            "width":442,
            "height":1
         },Global.WuYue_Imgsdm);
         ComponentUtil.getScaleBitmap("Line_Shu",[0,1,0,1],this,{
            "x":53,
            "y":54,
            "width":1,
            "height":79
         },Global.WuYue_Imgsdm);
         this._tfDate0 = ComponentUtil.getTextField("累计消费元宝",this,{
            "x":21,
            "y":6,
            "color":16764206
         });
         ComponentUtil.getTextField("元宝累计返还比例",this,{
            "x":10,
            "y":32,
            "color":11523767
         });
         this._tfDate1 = ComponentUtil.getTextField("5月10日",this,{
            "x":60,
            "y":59,
            "color":11523767
         });
         this._tfDate2 = ComponentUtil.getTextField("6月10日",this,{
            "x":60,
            "y":85,
            "color":11523767
         });
         this._tfDate3 = ComponentUtil.getTextField("7月10日",this,{
            "x":60,
            "y":111,
            "color":11523767
         });
         this._tfDate4 = ComponentUtil.getTextField("当前累计消费",this,{
            "x":10,
            "y":150,
            "color":11523767
         });
         ComponentUtil.getTextField("分期\n返利\n奖励",this,{
            "x":13,
            "y":64,
            "color":11523767,
            "size":12,
            "leading":6
         });
         this._processBar = new MaskProgressBar();
         this._processBar.x = 114;
         this._processBar.y = 156;
         this._processBar.bg = ComponentUtil.getBitmap("Progress_Back",this,{
            "x":-23,
            "y":-6
         },Global.WuYue_Imgsdm);
         this._processBar.bar = ComponentUtil.getBitmap("Progress",this,null,Global.WuYue_Imgsdm);
         this._processBar.realWidth = 304;
         this._processBar.init();
         addChild(this._processBar);
         this._tfBarValue = ComponentUtil.getTextField("",this,{
            "x":this._processBar.x + this._processBar.realWidth / 2,
            "y":this._processBar.y - 4,
            "color":16768307
         });
         this._tfBarValue.autoSize = TextFieldAutoSize.CENTER;
         this._tfMain = ComponentUtil.getTextField("",this,{
            "x":10,
            "y":182,
            "color":11523767
         });
         this.setTfGridsData(Model_ActivityGuide.getConsumeRewardStaticData());
         ComponentUtil.getTextField("",this,{
            "x":27.5,
            "y":-31
         }).htmlText = "<font color=\'#ffff33\'>领取时间：</font><font color=\'#33ff33\'>返利对应日期00:00邮件发送</font>";
      }
      
      private function biubiubiu(infos:Array) : void
      {
         var j:int = 0;
         var temp:Array = [];
         var tempA:Array = [];
         var i:int = 0;
         while(i < infos.length)
         {
            tempA = infos[i];
            j = 2;
            while(j < tempA.length)
            {
               if(temp[j - 2] == null)
               {
                  temp[j - 2] = [i + 1];
               }
               temp[j - 2].push(tempA[j]);
               j++;
            }
            i++;
         }
         infos = temp;
         var dic:DictionaryTabel = new DictionaryTabel();
         i = 0;
         while(i < infos.length)
         {
            temp = infos[i];
            temp.shift();
            dic[i + 1] = temp;
            i++;
         }
         Data_lib.czfl = dic;
         Data_lib.czfl.setLength(infos.length);
      }
      
      public function setTfGridsData(infos:Array) : void
      {
         var sx:Number = NaN;
         var sy:Number = NaN;
         var incx:Number = NaN;
         var incy:Number = NaN;
         var autoSize:String = null;
         var color:int = 0;
         var i:int = 0;
         var info:Array = null;
         var j:int = 0;
         var tf:MyTextField = null;
         var r:int = 0;
         var info1:Array = null;
         var c:int = 0;
         if(!this.gridIsInit)
         {
            sx = 113 + 33;
            sy = 7;
            incx = 66;
            incy = 26;
            autoSize = TextFieldAutoSize.CENTER;
            this.gridIsInit = true;
            this.gridArray = [];
            i = 0;
            while(i < infos.length)
            {
               info = infos[i];
               this.gridArray[i] = [];
               j = 1;
               while(j < info.length)
               {
                  if(j == 1)
                  {
                     color = 16764206;
                  }
                  else
                  {
                     color = 11523767;
                  }
                  tf = ComponentUtil.getTextField("",this,null);
                  tf.color = color;
                  tf.autoSize = autoSize;
                  tf.x = sx + i * incx;
                  tf.y = sy + (j - 1) * incy;
                  tf.text = j == 2 ? info[j].toString() + "%" : info[j].toString();
                  this.gridArray[i][j] = tf;
                  j += 1;
               }
               i += 1;
            }
         }
         else
         {
            r = 0;
            while(r < infos.length)
            {
               info1 = infos[r];
               c = 1;
               while(c < info1.length)
               {
                  this.gridArray[r][c].text = c == 2 ? info1[c].toString() + "%" : info1[c].toString();
                  c += 1;
               }
               r += 1;
            }
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
      }
      
      public function update(startTime:int, endTime:int, actTime1:int, actTime2:int, actTime3:int, count:int, next:int, curReward:int, nxtCost:int, reward:int) : void
      {
         this._tfDate0.text = "累计消费元宝";
         this._tfDate4.text = "当前累计消费";
         this.setTfGridsData(Model_ActivityGuide.getConsumeRewardStaticData());
         var sDate:Date = new Date(startTime * 1000);
         var eDate:Date = new Date(endTime * 1000);
         var txt:String = LangConfig.reTxt("<font color=\'#ffff00\'>活动时间：</font><font color=\'#00ff00\'>{0}-{1}</font>",LangConfig.reTxt("{0}年{1}月{2}日{3}:{4}",sDate.fullYear,sDate.month + 1,sDate.date,Enum_BroadCastTool.instance.getBitStr(eDate.hours),Enum_BroadCastTool.instance.getBitStr(sDate.minutes)),LangConfig.reTxt("{0}年{1}月{2}日{3}:{4}",eDate.fullYear,eDate.month + 1,eDate.date,Enum_BroadCastTool.instance.getBitStr(eDate.hours),Enum_BroadCastTool.instance.getBitStr(eDate.minutes)));
         txt = "<font color=\'#ffff00\'>活动时间：</font><font color=\'#00ff00\'>2013年9月6日10:00-2013年9月10日23:59</font>";
         this._tfBarValue.text = count.toString() + "/" + next.toString();
         this._tfMain.htmlText = LangConfig.reTxt("当前可获得<font color=\'#ffff33\'>{0}元宝</font>的返利，再消费<font color=\'#ffff33\'>{1}元宝</font>可以获得<font color=\'#33ff33\'>{2}元宝</font>返利",curReward,nxtCost,reward);
         var date1:Date = new Date(actTime1 * 1000);
         this._tfDate1.text = LangConfig.reTxt("{0}月{1}日",date1.month + 1,date1.date);
         var date2:Date = new Date(actTime2 * 1000);
         this._tfDate2.text = LangConfig.reTxt("{0}月{1}日",date2.month + 1,date2.date);
         var date3:Date = new Date(actTime3 * 1000);
         this._tfDate3.text = LangConfig.reTxt("{0}月{1}日",date3.month + 1,date3.date);
         var vo:ActivityGuideVo = View_ActivityGuidePanel.instance.getData();
         if(vo.type == Enum_ActivityGuide.ACTIVITY_COSTREWARD)
         {
            View_ActivityGuidePanel.instance.setData(vo);
         }
         Tween.to(this._processBar,500,{"persent":[0,count / next]},null,null,Tween.SIN);
      }
      
      public function Update_ChongZhiFanLi(current:int) : void
      {
         var curReward:int = 0;
         var nxtCost:int = 0;
         var reward:int = 0;
         var total:int = 0;
         this._tfDate0.text = "累计充值元宝";
         this._tfDate4.text = "当前累计充值";
         this._tfDate1.text = Data_lib.czflsj[1][0];
         this._tfDate2.text = Data_lib.czflsj[2][0];
         this._tfDate3.text = Data_lib.czflsj[3][0];
         this.setTfGridsData(Data_lib.czfl.toArray());
         var len:int = int(Data_lib.czfl.getLength());
         current = Math.min(current,Data_lib.czfl[len][0]);
         var i:int = 1;
         while(i <= len && current >= Data_lib.czfl[i][0])
         {
            i++;
         }
         if(i > len)
         {
            nxtCost = 0;
            reward = 0;
            curReward = Data_lib.czfl[len][0] * Data_lib.czfl[len][1] / 100;
            total = int(Data_lib.czfl[len][0]);
         }
         else if(i == 1)
         {
            nxtCost = Data_lib.czfl[i][0] - current;
            reward = Data_lib.czfl[i][0] * Data_lib.czfl[i][1] / 100;
            curReward = 0;
            total = int(Data_lib.czfl[i][0]);
         }
         else
         {
            nxtCost = Data_lib.czfl[i][0] - current;
            reward = Data_lib.czfl[i][0] * Data_lib.czfl[i][1] / 100;
            curReward = Data_lib.czfl[i - 1][0] * Data_lib.czfl[i - 1][1] / 100;
            total = int(Data_lib.czfl[i][0]);
         }
         this._tfBarValue.text = current.toString() + "/" + total.toString();
         Tween.to(this._processBar,500,{"persent":[0,current / total]},null,null,Tween.SIN);
         this._tfMain.htmlText = LangConfig.reTxt("当前可获得<font color=\'#ffff33\'>{0}元宝</font>的返利，再充值<font color=\'#ffff33\'>{1}元宝</font>可以获得<font color=\'#33ff33\'>{2}元宝</font>返利",curReward,nxtCost,reward);
         var vo:ActivityGuideVo = View_ActivityGuidePanel.instance.getData();
         if(vo.type == Enum_ActivityGuide.ChongZhiFanLi_ID)
         {
            vo.time = Data_lib.hd[34][4];
            View_ActivityGuidePanel.instance.setData(vo);
         }
      }
   }
}

