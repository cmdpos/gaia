
  # 1. 下载远程src到本地
  504  git fetch origin
  503  git checkout -b dev origin/dev
  
  # 2. 下载远程dst到本地，并把src merge到dst
  504  git fetch origin
  505  git checkout origin/dev_multi_voting
  506  git merge --no-ff dev
  
  # 3. 修改冲突
  
  # 4. 提交到远程dst
  510  git add .
  512  git commit
  515  git push origin HEAD:dev_multi_voting
