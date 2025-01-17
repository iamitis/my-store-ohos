// import { router } from '@kit.ArkUI';
//
// // 引入Context相关
// import { common } from '@kit.AbilityKit';
//
// // 引入RDB数据库
// import { relationalStore } from '@kit.ArkData';
// import { BusinessError } from '@kit.BasicServicesKit';
//
// @Preview
// @Entry
// @Component
// struct LoginPage {
//   @State message: string = '登录页';
//   @State btnMsg: string = '登录';
//   @State account: string = ''; // 账号
//   @State password: string = ''; // 密码
//   // 获取Context
//   private context = getContext(this) as common.UIAbilityContext;
//   // 定义RdbStore
//   private rdbStore: relationalStore.RdbStore | undefined = undefined;
//
//   aboutToAppear(): void {
//     // 构造StoreConfig对象
//     const STORE_CONFIG: relationalStore.StoreConfig = {
//       name: 'RdbTest.db', // 数据库文件名
//       securityLevel: relationalStore.SecurityLevel.S1, // 数据库安全级别
//       encrypt: false, // 可选参数，指定数据库是否加密，默认不加密
//       customDir: 'customDir/subCustomDir', // 可选参数，数据库自定义路径
//       isReadOnly: false // 可选参数，指定数据库是否以只读方式打开
//     };
//
//     // 获得一个相关的RdbStore
//     relationalStore.getRdbStore(this.context, STORE_CONFIG, (err, store) => {
//       if (err) {
//         console.error(`At LoginPage Failed to get RdbStore. Code:${err.code}, message:${err.message}`);
//         return;
//       }
//       console.info('At LoginPage Succeeded in getting RdbStore.');
//       // 当数据库创建时，数据库默认版本为0
//       if (store.version === 0) {
//         const SQL_CREATE_TABLE = 'CREATE TABLE IF NOT EXISTS CLIENT_USER (ID INTEGER PRIMARY KEY AUTOINCREMENT, ACCOUNT TEXT NOT NULL, PASSWORD TEXT NOT NULL)';
//         store.executeSql(SQL_CREATE_TABLE); // 创建数据表
//         store.version = 1; // 设置数据库的版本
//       }
//       this.rdbStore = store; // 赋值给当前的rdbStore对象
//     });
//   }
//
//   build() {
//     Column() {
//       Text(this.message)
//         .id('您好')
//         .fontSize(20)
//         .fontWeight(FontWeight.Bold)
//         .width('100%')
//         .height(50)
//         .textAlign(TextAlign.Center)
//         .backgroundColor(0xF1F3F5)
//       Image($r('app.media.startIcon'))
//         .width(150)
//         .height(150)
//         .margin({ top: 40, bottom: 40 })
//       TextInput({ placeholder: '请输入手机号' })
//         .maxLength(11)
//         .type(InputType.Number)
//         .inputStyle()
//         .onChange((value: string) => {
//           this.account = value;
//         })
//       Line().lineStyle()
//       TextInput({ placeholder: '请输入密码' })
//         .maxLength(12)
//         .type(InputType.Password)
//         .inputStyle()
//         .onChange((value: string) => {
//           this.password = value;
//         })
//       Line().lineStyle()
//       Button(this.btnMsg)
//         .width('80%')
//         .margin({ top: 100 })
//         .height(50)
//         .onClick(() => {
//           if (this.account === undefined || this.account === '') {
//             AlertDialog.show({
//               message: "请输入账号",
//               autoCancel: true,
//             })
//             return
//           }
//           if (this.password === undefined || this.password === '') {
//             AlertDialog.show({
//               message: "请输入密码",
//               autoCancel: true,
//             })
//             return
//           }
//           // 使用ArkData RDB数据库 以查找方式验证用户信息
//           if (this.rdbStore !== undefined) {
//             const predicates = new relationalStore.RdbPredicates('CLIENT_USER');
//             predicates.equalTo('ACCOUNT', this.account).equalTo('PASSWORD', this.password);
//             this.rdbStore.query(predicates, (err: BusinessError, resultSet: relationalStore.ResultSet) => {
//               if (err) {
//                 console.error(`At LoginPage，查询数据失败，错误代码：${err.code},错误提示：${err.message}`);
//                 return;
//               }
//               if (resultSet.rowCount > 0) {
//                 console.info(`At LoginPage，登录成功`);
//                 // 跳转到首页
//                 router.pushUrl({
//                   url: 'pages/Index',
//                   params: {
//                     account: this.account,
//                     password: this.password
//                   }
//                 })
//               } else {
//                 AlertDialog.show({
//                   message: "账号或密码错误",
//                   autoCancel: true,
//                 })
//               }
//             })
//           }
//         })
//       Button("注册新账号")
//         .width('40%')
//         .margin({ top: 10 })
//         .height(50)
//         .onClick(() => {
//           if (this.account === undefined || this.account === '') {
//             AlertDialog.show({
//               message: "请输入账号",
//               autoCancel: true,
//             })
//             return
//           }
//           if (this.password === undefined || this.password === '') {
//             AlertDialog.show({
//               message: "请输入密码",
//               autoCancel: true,
//             })
//             return
//           }
//           // 使用ArkData RDB数据库 以建表方式存储用户信息数据
//           if (this.rdbStore !== undefined) {
//             const userInfo: relationalStore.ValuesBucket = {
//               ACCOUNT: this.account,
//               PASSWORD: this.password
//             };
//             this.rdbStore.insert('CLIENT_USER', userInfo, (err: BusinessError, rowId: number) => {
//               if (rowId === -1) {
//                 console.error(`At LoginPage，插入数据失败，错误代码：${err.code},错误提示：${err.message}`)
//                 return
//               }
//               console.info(`At LoginPage，插入数据成功，rowId为 ${rowId}`)
//               AlertDialog.show({
//                 message: "注册成功",
//                 autoCancel: true,
//               })
//             })
//           }
//         })
//     }
//     .height('100%')
//     .width('100%')
//     .padding(0)
//   }
// }
//
// // TextInput组件的自定义样式扩展
// @Extend(TextInput)
// function inputStyle() {
//   .placeholderColor(Color.Gray) // 占位符颜色
//   .height(50) // 输入框高度
//   .fontSize(15) // 字体大小
//   .backgroundColor(0xF1F3F5) // 背景颜色
//   .width('90%') // 宽度为父组件的100%
//   .margin(10)
// }
//
// // Line组件的自定义样式扩展
// @Extend(Line)
// function lineStyle() {
//   .width('100%') // 宽度为父组件的100%
//   .height(1) // 高度
//   .backgroundColor(0xF1F3F5) // 背景颜色
// }
import { router } from '@kit.ArkUI';

// 引入Context相关
import { common } from '@kit.AbilityKit';

// 导入代码二中的API函数
import { login, register, ResponInfo, User } from '../api/UserApi';
import { GenericResponse } from '../utils/RequestUtil';

@Preview
@Entry
@Component
struct LoginPage {
  @State message: string = '登录页';
  @State btnMsg: string = '登录';
  @State account: string = ''; // 账号
  @State password: string = ''; // 密码
  // 获取Context
  private context = getContext(this) as common.UIAbilityContext;

  build() {
    Column() {
      Text(this.message)
        .id('您好')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .width('100%')
        .height(50)
        .textAlign(TextAlign.Center)
        .backgroundColor(0xF1F3F5)
      Image($r('app.media.startIcon'))
        .width(150)
        .height(150)
        .margin({ top: 40, bottom: 40 })
      TextInput({ placeholder: '请输入手机号' })
        .maxLength(11)
        .type(InputType.Number)
        .inputStyle()
        .onChange((value: string) => {
          this.account = value;
        })
      Line().lineStyle()
      TextInput({ placeholder: '请输入密码' })
        .maxLength(12)
        .type(InputType.Password)
        .inputStyle()
        .onChange((value: string) => {
          this.password = value;
        })
      Line().lineStyle()
      Button(this.btnMsg)
        .width('80%')
        .margin({ top: 100 })
        .height(50)
        .onClick(async () => { // 使用async函数以便进行API调用
          if (this.account === '' || this.account === undefined) {
            AlertDialog.show({
              message: "请输入账号",
              autoCancel: true,
            });
            return;
          }
          if (this.password === '' || this.password === undefined) {
            AlertDialog.show({
              message: "请输入密码",
              autoCancel: true,
            });
            return;
          }
          // 调用登录API
          try {
            const response = await login(this.account, this.password);
            const parsedResponse = JSON.parse(response.toString()!) as GenericResponse<boolean>;
            if (parsedResponse.result) {
              console.info('登录成功');
              // 跳转到首页
              router.pushUrl({
                url: 'pages/Index',
                params: {
                  account: this.account,
                  password: this.password
                }
              });
            } else {
              AlertDialog.show({
                message: "账号或密码错误",
                autoCancel: true,
              });
            }
          } catch (error) {
            console.error('登录失败', error);
            AlertDialog.show({
              message: "登录失败，请稍后再试",
              autoCancel: true,
            });
          }
        })
      Button("注册新账号")
        .width('40%')
        .margin({ top: 10 })
        .height(50)
        .onClick(async () => { // 使用async函数以便进行API调用
          if (this.account === '' || this.account === undefined) {
            AlertDialog.show({
              message: "请输入账号",
              autoCancel: true,
            });
            return;
          }
          if (this.password === '' || this.password === undefined) {
            AlertDialog.show({
              message: "请输入密码",
              autoCancel: true,
            });
            return;
          }
          // 调用注册API
          try {
            const newUser: User = {
              role: "PARENT",
              phone: this.account,
              password: this.password,
              related_phone: '',
            };
            const response = await register(newUser);
            const parsedResponse = JSON.parse(response.toString()!) as GenericResponse<ResponInfo>;
            if (parsedResponse.result) {
              console.info('注册成功');
              AlertDialog.show({
                message: "注册成功",
                autoCancel: true,
              });
            } else {
              AlertDialog.show({
                message:"注册失败",
                autoCancel: true,
              });
            }
          } catch (error) {
            console.error('出现错误', error);
            AlertDialog.show({
              message: "出现错误，请稍后再试",
              autoCancel: true,
            });
          }
        })
    }
    .height('100%')
    .width('100%')
    .padding(0)
  }
}

// TextInput组件的自定义样式扩展
@Extend(TextInput)
function inputStyle() {
  .placeholderColor(Color.Gray) // 占位符颜色
  .height(50) // 输入框高度
  .fontSize(15) // 字体大小
  .backgroundColor(0xF1F3F5) // 背景颜色
  .width('90%') // 宽度为父组件的100%
  .margin(10)
}

// Line组件的自定义样式扩展
@Extend(Line)
function lineStyle() {
  .width('100%') // 宽度为父组件的100%
  .height(1) // 高度
  .backgroundColor(0xF1F3F5) // 背景颜色
}