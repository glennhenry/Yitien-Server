package com.yiTian.view.modules.chatM
{
   import com.ui.controls.Button;
   import com.ui.controls.ScaleBitmap;
   import com.utils.ComponentUtil;
   import com.yiTian.Global;
   import com.yiTian.manager.LangConfig;
   import com.yiTian.manager.UIManager;
   import com.yiTian.scene.GameScene;
   import com.yiTian.utils.Utils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class Channel extends Sprite
   {
      
      private static var _instance:Channel;
      
      public static var visiMark:Boolean = false;
      
      private var Button_Team:Button;
      
      private var Button_Near:Button;
      
      private var Button_Gang:Button;
      
      private var Button_SendMessige:Button;
      
      private var Button_World:Button;
      
      private var Button_KuaFu:Button;
      
      private var _dataArr:Array = [{
         "txt":LangConfig.getWord("842",0),
         "x":5.95,
         "y":109 - 20
      },{
         "txt":LangConfig.getWord("843",0),
         "x":5.95,
         "y":129.15 - 20
      },{
         "txt":LangConfig.getWord("844",0),
         "x":5.95,
         "y":149.3 - 20
      },{
         "txt":LangConfig.getWord("523",0),
         "x":5.95,
         "y":169.45 - 20
      },{
         "txt":LangConfig.getWord("845",0),
         "x":5.95,
         "y":189.6 - 20
      },{
         "txt":"跨服",
         "x":5.95,
         "y":209.75 - 20
      }];
      
      private var back:ScaleBitmap;
      
      public function Channel()
      {
         super();
         GameScene.sysLayer.addChild(this);
         mouseChildren = true;
         this.init();
      }
      
      public static function get instance() : Channel
      {
         if(!_instance)
         {
            _instance = new Channel();
         }
         return _instance;
      }
      
      private function init() : void
      {
         var pro:Object = null;
         var btn:Button = null;
         this.back = ComponentUtil.getScaleBitmap("Back_Floating",[8,9,4,2],this,{
            "x":1,
            "y":104 - 20,
            "width":58,
            "height":113 + 20
         },Global.Img_Cdm);
         this.Button_Team = ComponentUtil.getButton(LangConfig.getWord("844",0),"ChannelButtonTwo",this,{
            "x":5.95,
            "y":45.3 + 104 - 20
         },ComponentUtil.domain);
         this.Button_Near = ComponentUtil.getButton(LangConfig.getWord("843",0),"ChannelButtonTwo",this,{
            "x":5.95,
            "y":25.15 + 104 - 20
         },ComponentUtil.domain);
         this.Button_Gang = ComponentUtil.getButton(LangConfig.getWord("523",0),"ChannelButtonTwo",this,{
            "x":5.95,
            "y":65.45 + 104 - 20
         },ComponentUtil.domain);
         this.Button_SendMessige = ComponentUtil.getButton(LangConfig.getWord("845",0),"ChannelButtonTwo",this,{
            "x":5.95,
            "y":85.7 + 104 - 20
         },ComponentUtil.domain);
         this.Button_World = ComponentUtil.getButton(LangConfig.getWord("842",0),"ChannelButtonTwo",this,{
            "x":5.95,
            "y":5 + 104 - 20
         },ComponentUtil.domain);
         this.Button_KuaFu = ComponentUtil.getButton("跨服","ChannelButtonTwo",this,{
            "x":5.95,
            "y":105.85 + 104 - 20
         },ComponentUtil.domain);
         var i:int = 0;
         while(i < this._dataArr.length)
         {
            pro = this._dataArr[i];
            btn = ComponentUtil.getButton(pro.txt,"ChannelButtonTwo",this,{
               "x":pro.x,
               "y":pro.y,
               "tabIndex":i + 1
            },ComponentUtil.domain);
            btn.addEventListener(MouseEvent.CLICK,this.cliHd);
            i++;
         }
         addEventListener(MouseEvent.MOUSE_DOWN,this.downHd);
      }
      
      private function downHd(e:MouseEvent) : void
      {
         trace(e.target);
      }
      
      private function cliHd(e:MouseEvent) : void
      {
         switch(e.target.tabIndex)
         {
            case 1:
               UIManager.chatPanel.TabButton_jianghu.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
               break;
            case 2:
               UIManager.chatPanel.TabButton_fujian.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
               break;
            case 3:
               UIManager.chatPanel.TabButton_duiwu.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
               break;
            case 4:
               UIManager.chatPanel.TabButton_banghui.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
               break;
            case 5:
               UIManager.chatPanel.liaotian_laba.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
               Utils.print("系统不做处理");
               break;
            case 6:
               UIManager.chatPanel.TabButton_kuafu.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
         }
      }
      
      override public function set visible(value:Boolean) : void
      {
         super.visible = value;
         if(value)
         {
            stage.addEventListener(MouseEvent.MOUSE_UP,function(e:MouseEvent):void
            {
               e.stopPropagation();
               stage.removeEventListener(MouseEvent.MOUSE_UP,arguments.callee);
               visible = false;
            });
         }
      }
   }
}

