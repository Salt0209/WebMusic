using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using BTL_LWNC_WebAmNhac.Data;
using BTL_LWNC_WebAmNhac.Models;
using System.Security.Claims;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication;
using System.Xml.Linq;
using Microsoft.AspNetCore.Authorization;
using BTL_LWNC_WebAmNhac.Services;

namespace BTL_LWNC_WebAmNhac.Controllers
{
    public class AccountController : Controller
	{
		private readonly BTL_LWNC_WebAmNhacContext _context;

		public AccountController(BTL_LWNC_WebAmNhacContext context)
		{
			_context = context;
		}

        #region Check/Login/Logout
        public IActionResult Login()
		{
			return View();
		}
		public async Task<IActionResult> LogOut()
		{
			//SignOutAsync is Extension method for SignOut    
			await HttpContext.SignOutAsync(CookieAuthenticationDefaults.AuthenticationScheme);
			//Redirect to home page    
			return RedirectToAction("Index", "Home");
		}
		[HttpPost]
		public async Task<JsonResult> Login(string email, string password)
		{
			var user = _context.User.Where(p => p.Email == email && p.Password == password).FirstOrDefault<User>();
			if (user == null || _context.User == null)
			{
                return Json(new { code = 500, msg = "Đăng nhập thất bại:"});
            }
			var claims = new List<Claim>
			{
				new Claim(ClaimTypes.Name, user.Email),
                new Claim("FullName", user.Name),
                new Claim("UserId", user.ID.ToString()),
                new Claim(ClaimTypes.Role, user.Role.Trim()),
			};

			System.Diagnostics.Debug.WriteLine($"User registered: {user.ID}");

			var claimsIdentity = new ClaimsIdentity(
			claims, CookieAuthenticationDefaults.AuthenticationScheme);
            await HttpContext.SignInAsync(
            CookieAuthenticationDefaults.AuthenticationScheme,
            new ClaimsPrincipal(claimsIdentity));

/*            _logger.LogInformation("User {Email} logged in at {Time}.",
            user.Email, DateTime.UtcNow);*/


            return Json(new { code = 200, response = user, msg = "Đăng nhập thành công" });
        }
		public JsonResult CheckLogin()
		{
			bool check = IsLogin();

            return Json(new { code = 200, response = check, msg = "Đã check" });
		}
        [HttpGet]
        public IActionResult IsLoggedIn()
        {
            bool isLoggedIn = IsLogin(); // Assuming IsLogin() is a method in your controller
            return Json(new { isLoggedIn });
        }
        public bool IsLogin()
		{
			return User.Identity.IsAuthenticated;

        }
        #endregion

        #region Favourite
        [HttpGet]
        public JsonResult ChangeFavourite(int id)
        {
            try
            {
				var userId = Int32.Parse(User.FindFirst("UserId").Value);
                var list = _context.UserFavourite.FirstOrDefault(p=>p.UserID==userId&&p.PlaylistID==id);
				if (list == null)
				{
					var newFav = new UserFavourite(userId,id);
					_context.UserFavourite.Add(newFav);
					_context.SaveChanges();
					return Json(new { code = 200, list = list, msg = "Thêm mới thành công" });
                }
				_context.UserFavourite.Remove(list);
				_context.SaveChanges();
				return Json(new { code = 200, list = list, msg = "Xoá thành công" });
            }
            catch (Exception ex)
            {
				var a = ex.Message;
                return Json(new { code = 500, msg = "Lấy dữ liệu thất bại:" + ex.Message });
            }
        }
        [HttpGet]
		[Authorize]
        public JsonResult RemoveFavourite(int id)
        {
            try
            {
                var userId = Int32.Parse(User.FindFirst("UserId").Value);
                var list = _context.UserFavourite.FirstOrDefault(p => p.UserID == userId && p.PlaylistID == id);
                _context.UserFavourite.Remove(list);
                _context.SaveChanges();
                return Json(new { code = 200, list = list, msg = "Xoá thành công" });
            }
            catch (Exception ex)
            {
                var a = ex.Message;
                return Json(new { code = 500, msg = "Lấy dữ liệu thất bại:" + ex.Message });
            }
        }
        #endregion

        #region Register
        public IActionResult Register()
		{
			return View();
		}

		[HttpPost]
		public async Task<JsonResult> Register(string name,string email, int age, string password)
		{
			if (await _context.User.AsNoTracking().FirstOrDefaultAsync(p => p.Email == email) != null)
			{
                return Json(new { code = 400, msg = "Email đã tồn tại" });
            }

			var newUser = new User
			{
				Name = name,
				Email = email,
				Age = age,
				Password = password,
				Role = "User"
			};
			try
			{
                _context.User.Add(newUser);
                _context.SaveChangesAsync();
                return Json(new { code = 200, msg = "Đăng ký thành công" });
            }
			catch(DbUpdateConcurrencyException) {
                return Json(new { code = 500, msg = "Đăng ký thất bại" });
            }
        }
        #endregion

        #region Profile
        public async Task<JsonResult> getProfile() {
            var userIdClaim = User.FindFirst("UserId");
            if (userIdClaim != null)
            {
                string userId = userIdClaim.Value;
                // Đây là ID của người dùng đang đăng nhập
                var user = _context.User.Where(p => p.ID == Int32.Parse(userId))
                    .Select(p=> new
                    {
                        p.Name,
                        p.Email,
                        p.Age,
                        p.Role
                    });
                return Json(new { code = 200,data = user, msg = "Bad Request" });
            }

            return Json(new { code = 400, msg="Bad Request" });
            
        }
        #endregion

        private bool UserExists(int id)
		{
		  return (_context.User?.Any(e => e.ID == id)).GetValueOrDefault();
		}
	}
}
