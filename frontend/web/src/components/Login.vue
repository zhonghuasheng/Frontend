<template>
  <div class="row">
    <form class="col-12" @submit.prevent="loginAction" enctype="multipart/form-data">
      <div class="form-group">
          <label>用户名</label>
          <input type="text" class="form-control" v-model="user.email" placeholder="请输入邮箱">
      </div>
      <div class="form-group">
        <label>密码</label>
        <input type="password" class="form-control" v-model="user.password" placeholder="请输入密码">
      </div>
      <button type="submit" class="btn btn-primary">登录</button>
    </form>
  </div>
</template>

<script>
export default {
  name: 'Login',
  data () {
    return {
      user: {
        email: '',
        password: ''
      }
    }
  },
  methods: {
    loginAction () {
      var formData = new FormData()
      formData.append('email', this.user.email)
      formData.append('password', this.user.password)

      this.axios.post('http://localhost:8081/user/login', formData).then((response) => {
        console.log(response.data)
        console.log('s')
      }).catch((response) => {
        console.log(response.data)
        console.log('f')
      })
    }
  }
}
</script>
