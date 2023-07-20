# README

## Demo

[demo endpoint](https://hahow-backend-b2b-q3.fly.dev/)


## Deployment

deploy this project to fly.io

```bash
  fly deploy
```
## 完成
 - rspec api 測試
 - grape api 實作
 - swagger 文件
 - Fly io 部署
## 說明
- 我們該如何執行這個 server
  - step 1 
    `git clone https://github.com/TedxTed/hahow-backend-b2b-q3.git`
  - step 2 
    `bundle`
  - step 3
    - `bundle exec rails db:create`
    - `bundle exec rails db:migrate`
  - step 4
    `bundle exec rails server`
- 專案的架構，API server 的架構邏輯
  1. `/api` end point
  2. version `/v1` 版本號
  3. restful api 
     - get `/course`
       - `/all`全部課程
       - `/id` 指定課程
       - 由 service object `FullCourseInfoService` 提供
     - post `/course`
       - 新增課程
       - 由 service object `CourseCreateService` 提供
     - patch `course`
       - 更新課程
       - 由 service object `CourseUpdaterService` 提供
     - delete `course`
       - 刪除課程
       - 由 service object `CourseDeleteService` 提供
  
- 你對於使用到的第三方 Gem 的理解，以及他們的功能簡介
  - grape api
    - 提供DSL簡化API開發流程
    - 輕量化的grape所建立的API在使用上會更有效率
    - 支援swagger文件自動生成
  
- 你在程式碼中寫註解的原則，遇到什麼狀況會寫註解
  - 當程式邏輯沒辦法表達實作的目的時(但要思考 調整命名或重構程式)

-  當有多種實作方式時，請說明為什麼你會選擇此種方式
   -  會使用grape api 實作是因為我需要專注在api的開發，可以少很多多餘的module分心
   -  使用service object提供服務：
      -  好處1: 在grape api 類別內我可以專注回傳值處理(http status & response)
      -  好處2: 易於後續擴充時使用，像是`FullCourseInfoService` 在很多地方都會使用到
   - Fly io
     - 部署平台
     - 好處1: 有免費方案
     - 好處2: 會自動產生dockerfile
  
- 在這份專案中你遇到的困難、問題，以及解決的方法
  - request body 及 response body決定
    - 在寫測試時慢慢調整
  - error處理
    - 不斷地測試看是否有遺漏的錯誤未被rescue
  
## Swagger

[Swagger](https://github.com/TedxTed/hahow-backend-b2b-q3/wiki/Swagger)

