package com.yiTian.view.modules.test
{
   import Layout.HGroup;
   import com.ui.containers.Canvas;
   import com.ui.controls.Button;
   import com.ui.controls.MyTextField;
   import com.ui.controls.TextInput;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.ResourceVersionConfig;
   import com.yiTian.manager.SocketManager;
   import com.yiTian.manager.UIManager;
   import com.yiTian.net.message.cg.ChatCGMessage;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.utils.Pool;
   import com.yiTian.utils.Utils;
   import com.yiTian.view.Panel123;
   import com.yiTian.view.comp.View_Alert;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   public class TestPackage extends Panel123
   {
      
      private static var instance:TestPackage;
      
      private var hbox:HGroup;
      
      private var txtArr:Vector.<MTxt>;
      
      private var cmd:TextInput;
      
      private var counst:TextInput;
      
      private var log:MyTextField;
      
      private var date:Date;
      
      private var canv:Canvas;
      
      private var temp:String = "";
      
      private var flag:int;
      
      private var timeFlag:int;
      
      public function TestPackage()
      {
         super();
         init();
      }
      
      public static function getInstance() : TestPackage
      {
         if(!instance)
         {
            instance = new TestPackage();
         }
         return instance;
      }
      
      override protected function initStaticView() : void
      {
         this.txtArr = new Vector.<MTxt>();
         ComponentUtil.getScaleBitmap("Back1",[149,41,2,5],this,{
            "x":0,
            "y":0,
            "width":510,
            "height":345
         },Global.Img_Cdm);
         ComponentUtil.getTextField("倚  天",this,{
            "x":236,
            "y":8,
            "color":16772287,
            "size":12,
            "leading":0
         });
         ComponentUtil.getButton("","Button_Close",this,{
            "x":467,
            "y":6,
            "textColor":16771436,
            "callBack":function():void
            {
               visible = false;
            }
         },Global.Img_Cdm);
         ComponentUtil.getScaleBitmap("Back3",[4,4,1,1],this,{
            "x":25,
            "y":42,
            "width":457,
            "height":295
         },Global.Img_Cdm);
         ComponentUtil.getTextField("协议号：",this,{
            "x":38,
            "y":58,
            "color":16772287,
            "size":12,
            "leading":0
         });
         ComponentUtil.getScaleBitmap("Back2",[2,2,15,15],this,{
            "x":90,
            "y":58,
            "width":66,
            "height":20
         },Global.Img_Cdm);
         this.cmd = ComponentUtil.getTextInput("输入协议号","TextInput1",this,{
            "x":92,
            "y":57,
            "BackgroundColor":10066329
         });
         ComponentUtil.getButton("关服","Button_GreenTwo",this,{
            "x":410,
            "y":57,
            "textColor":16771436,
            "callBack":this.clickHandler
         },Global.Img_Cdm);
         ComponentUtil.getButton("点击发送","Button_GreenTwo",this,{
            "x":385,
            "y":303,
            "textColor":16771436,
            "callBack":this.clickHandler
         },Global.Img_Cdm);
         ComponentUtil.getTextField("发送次数",this,{
            "x":344,
            "y":282,
            "color":16772287,
            "size":12,
            "leading":0
         });
         ComponentUtil.getScaleBitmap("Back2",[2,2,15,15],this,{
            "x":404,
            "y":281,
            "width":35,
            "height":20
         },Global.Img_Cdm);
         this.counst = ComponentUtil.getTextInput("2","TextInput1",this,{
            "x":408,
            "y":282,
            "realWidth":60,
            "BackgroundColor":3394815
         });
         ComponentUtil.getButton("INT","Button_GreenTwo",this,{
            "x":30,
            "y":83,
            "textColor":16771436,
            "callBack":this.click
         },Global.Img_Cdm);
         ComponentUtil.getButton("UTF","Button_GreenTwo",this,{
            "x":88,
            "y":82,
            "textColor":16771436,
            "callBack":this.click
         },Global.Img_Cdm);
         ComponentUtil.getButton("short","Button_GreenTwo",this,{
            "x":147,
            "y":82,
            "textColor":16771436,
            "callBack":this.click
         },Global.Img_Cdm);
         ComponentUtil.getButton("Byte","Button_GreenTwo",this,{
            "x":211,
            "y":83,
            "textColor":16771436,
            "callBack":this.click
         },Global.Img_Cdm);
         ComponentUtil.getButton("Long","Button_GreenTwo",this,{
            "x":275,
            "y":83,
            "textColor":16771436,
            "callBack":this.click
         },Global.Img_Cdm);
         ComponentUtil.getButton("清除参数","Button_GreenTwo",this,{
            "x":339,
            "y":83,
            "textColor":16771436,
            "callBack":this.clickHandler
         },Global.Img_Cdm);
         ComponentUtil.getButton("清除记录","Button_GreenTwo",this,{
            "x":403,
            "y":83,
            "textColor":16771436,
            "callBack":this.clickHandler
         },Global.Img_Cdm);
         ComponentUtil.getTextField("日  志",this,{
            "x":327,
            "y":108,
            "color":16772287,
            "size":12,
            "realWidth":40,
            "realHeight":20,
            "leading":0,
            "wordWrap":true,
            "bold":true
         });
         ComponentUtil.getScaleBitmap("Back2",[2,2,15,15],this,{
            "x":237,
            "y":126,
            "width":200,
            "height":150
         },Global.Img_Cdm);
         this.canv = new Canvas(200,150);
         this.canv.x = 237;
         this.canv.y = 126;
         this.addChild(this.canv);
         this.log = ComponentUtil.getTextField("",this.canv,{
            "color":16772287,
            "size":12,
            "leading":0,
            "wordWrap":true,
            "realWidth":180
         });
         this.log.mouseEnabled = true;
         move = new Rectangle(0,0,450,36);
         this.hbox = new HGroup(30,110,400,300,30,0);
         Global.control.registerCallBack("删除参数",this.del);
         this.cmd.addEventListener(MouseEvent.CLICK,this.onInp);
         this.date = new Date();
      }
      
      protected function onInp(event:MouseEvent) : void
      {
         this.cmd.text = "";
      }
      
      private function clickHandler(evt:MouseEvent) : void
      {
         var count:int = 0;
         var str:String = null;
         var i:int = 0;
         var tt:MTxt = null;
         var ii:int = 0;
         var time:String = null;
         var b:Button = evt.target as Button;
         switch(b.label)
         {
            case "关服":
               if(ResourceVersionConfig.isRelease == false)
               {
                  View_Alert.show("是否关闭服务器（内网测试有效）？",View_Alert.OK_CANCAL,function():void
                  {
                     ChatCGMessage.CG_CHAT(2,"allsystemexit");
                  });
               }
               break;
            case "清除记录":
               this.flag = 0;
               this.temp = "";
               this.log.text = "";
               break;
            case "清除参数":
               this.hbox.clearItem();
               i = 0;
               while(i < this.txtArr.length)
               {
                  tt = this.txtArr[i];
                  if(Boolean(tt) && Boolean(tt.parent))
                  {
                     tt.parent.removeChild(tt);
                  }
                  i++;
               }
               break;
            case "点击发送":
               if(int(this.cmd.text) < 20)
               {
                  UIManager.centerBroadcast.addMsg("屌丝，再乱发暴你菊！");
                  return;
               }
               count = int(this.counst.text);
               count = count == 0 ? 1 : count;
               str = "";
               i = 0;
               while(i < this.txtArr.length)
               {
                  str += "  " + Model_Pak.getRealType(this.txtArr[i].text,this.txtArr[i].type);
                  i++;
               }
               ii = 0;
               while(ii < count)
               {
                  ++this.flag;
                  SocketManager.send(int(this.cmd.text),Model_Pak.getByteArr(this.getData()));
                  time = (this.date.minutes < 10 ? "0" + this.date.minutes : this.date.minutes) + ":" + (this.date.seconds < 10 ? "0" + this.date.seconds : this.date.seconds);
                  this.temp += HtmlUtil.font("\n" + time,"#04ff00") + " " + "协议号:" + this.cmd.text + "\n参数:" + str + "  第" + this.flag + "条";
                  ii++;
               }
               this.log.htmlText = this.temp;
               this.canv.align();
         }
      }
      
      private function click(evt:MouseEvent) : void
      {
         var b:Button = evt.target as Button;
         var txt:MTxt = Pool.getObject(MTxt);
         this.addChild(txt);
         this.hbox.appendItem(txt);
         txt.index = this.txtArr.length + 1;
         txt.type = b.label;
         this.txtArr.push(txt);
         this.hbox.align();
      }
      
      private function getData() : Array
      {
         var arr:Array = [];
         var i:int = 0;
         while(i < this.txtArr.length)
         {
            arr.push([this.txtArr[i].type,this.txtArr[i].text]);
            i++;
         }
         return arr;
      }
      
      private function del(data:Object) : void
      {
         var len:int;
         var i:int;
         var txt:MTxt = null;
         if(this.timeFlag == 0)
         {
            this.timeFlag = setTimeout(function():void
            {
               clearTimeout(timeFlag);
               timeFlag = 0;
            },100);
            len = int(this.txtArr.length);
            i = 0;
            while(i < len)
            {
               txt = this.txtArr[i];
               if(txt.index == int(data))
               {
                  if(Boolean(txt) && Boolean(txt.parent))
                  {
                     txt.parent.removeChild(txt);
                     this.hbox.dependItem(txt);
                  }
                  this.txtArr.splice(i,1);
                  break;
               }
               i++;
            }
            this.resetIndex();
            return;
         }
      }
      
      private function resetIndex() : void
      {
         var len:int = int(this.txtArr.length);
         var i:int = 0;
         while(i < len)
         {
            (this.txtArr[i] as MTxt).index = i + 1;
            i++;
         }
         this.hbox.align();
      }
      
      override public function set visible(value:Boolean) : void
      {
         if(ResourceVersionConfig.isRelease)
         {
            Utils.print("居然执行了");
            return;
         }
         super.visible = value;
      }
   }
}

