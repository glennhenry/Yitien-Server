package com.yiTian.net.handler
{
   import com.yiTian.Global;
   import com.yiTian.data.model.Model_ZhaoCaiMao;
   import com.yiTian.data.vo.Vo_ZhaoCaiMao;
   import com.yiTian.manager.UIManager;
   import com.yiTian.utils.HtmlUtil;
   import com.yiTian.view.modules.zhaocaimao.View_ZhaoCaiMao;
   
   public class ZhaoCaiMaoHandler
   {
      
      public function ZhaoCaiMaoHandler()
      {
         super();
      }
      
      public static function GC_ZHAOCAIMAO_OPENWIN(time:int, mindex:String, page:int, page1:int, voVec:Vector.<Vo_ZhaoCaiMao>) : void
      {
         var model:Model_ZhaoCaiMao = null;
         model = Model_ZhaoCaiMao.instance;
         model.maxPage = page;
         model.currentPage = page1;
         model.myIndex = mindex;
         model.currentZM = time;
         model.data = voVec;
         Global.delegate.dosomething(View_ZhaoCaiMao.instance,function():void
         {
            if(!View_ZhaoCaiMao.instance.visible)
            {
               View_ZhaoCaiMao.instance.visible = true;
            }
            View_ZhaoCaiMao.instance.update();
         });
      }
      
      public static function GC_ZHAOCAIMAO_WEIYANG(reslut:int, roleID:Number) : void
      {
         var str:String = null;
         switch(reslut)
         {
            case 1:
               str = "等级不足30级！";
               break;
            case 2:
               str = "已被喂养过了!";
               break;
            case 3:
               str = "今天没有剩余的次数了！";
               break;
            case 4:
               str = "饲养成功！";
               View_ZhaoCaiMao.instance.showEff(roleID);
               break;
            case 5:
               str = "不能喂养自己的招财猫！";
               break;
            case 6:
               str = "这只招财猫今天的喂养次数已达上限！";
         }
         UIManager.centerBroadcast.addMsg(str);
      }
      
      public static function GC_ZHAOCAIMAO_LY(reslut:int) : void
      {
         var str:String = null;
         switch(reslut)
         {
            case 1:
               str = "等级不足30级！";
               break;
            case 2:
               str = "您已经有招财猫了";
               break;
            case 3:
               str = "领养成功！";
         }
         UIManager.centerBroadcast.addMsg(str);
      }
      
      public static function GC_ZHAOCAIMAO_SEARCH(reslut:int) : void
      {
         var str:String = null;
         switch(reslut)
         {
            case 1:
               str = "等级不足30级！";
               break;
            case 2:
               str = "没有这只喵！";
         }
         UIManager.centerBroadcast.addMsg(str);
      }
      
      public static function GC_ZHAOCAIMAO_ZHAOMU(reslut:int, time:int) : void
      {
         var str:String = null;
         var model:Model_ZhaoCaiMao = Model_ZhaoCaiMao.instance;
         model.currentZM = time;
         switch(reslut)
         {
            case 1:
               str = "等级不足30级！";
               break;
            case 2:
               str = "没有这只喵！";
               break;
            case 3:
               str = "操作太频繁！";
               break;
            case 4:
               str = "招募成功！";
         }
         UIManager.centerBroadcast.addMsg(str);
      }
      
      public static function GC_ZHAOCAIMAO_PAGE(time:int, mindex:String, page:int, page1:int, voVec:Vector.<Vo_ZhaoCaiMao>) : void
      {
         var model:Model_ZhaoCaiMao = Model_ZhaoCaiMao.instance;
         model.maxPage = page;
         model.currentPage = page1;
         model.myIndex = mindex;
         model.currentZM = time;
         model.data = voVec;
         Global.delegate.dosomething(View_ZhaoCaiMao.instance,function():void
         {
            View_ZhaoCaiMao.instance.update();
         });
      }
      
      public static function GC_ZHAOCAIMAO_GB(roleName:String = "", roleID:Number = 1) : void
      {
         var msg:String = "<font color=\'#FF0000\'> " + "灵猫饲养" + "   </font><a href=\'event:nianshou_\'>" + HtmlUtil.underLine(HtmlUtil.font(roleName,"#33CCFF")) + "</a>的招财灵猫很饿啦，大家快来帮我喂养！" + "<font color=\'#FFFF00\'>【</font><a href=\'event:nianshou_\'>" + HtmlUtil.underLine(HtmlUtil.font("我要帮忙","#FFFF00")) + "</a><font color=\'#FFFF00\'>】</font>";
         UIManager.chatPanel.add(msg,roleID,888,roleName);
      }
   }
}

