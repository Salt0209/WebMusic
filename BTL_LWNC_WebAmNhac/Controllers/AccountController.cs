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

		// GET: Users
		public async Task<IActionResult> Index()
		{
			  return _context.User != null ? 
						  View(await _context.User.ToListAsync()) :
						  Problem("Entity set 'BTL_LWNC_WebAmNhacContext.User'  is null.");
		}

		// GET: Users/Details/5
		public async Task<IActionResult> Details(int? id)
		{
			if (id == null || _context.User == null)
			{
				return NotFound();
			}

			var user = await _context.User
				.FirstOrDefaultAsync(m => m.ID == id);
			if (user == null)
			{
				return NotFound();
			}

			return View(user);
		}
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

            return Json(new { code = 200, response = check, msg = "Đã check" }); ;
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
        public IActionResult Register()
		{
			return View();
		}

		[HttpPost]
		public JsonResult Register(string name,string email, int age, string password)
		{
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

		// GET: Users/Create
		public IActionResult Create()
		{
			return View();
		}

		// POST: Users/Create
		// To protect from overposting attacks, enable the specific properties you want to bind to.
		// For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
		[HttpPost]
		[ValidateAntiForgeryToken]
		public async Task<IActionResult> Create([Bind("ID,Name,Email,Password,Role")] User user)
		{
			if (ModelState.IsValid)
			{
				_context.Add(user);
				await _context.SaveChangesAsync();
				return RedirectToAction(nameof(Index));
			}
			return View(user);
		}

		// GET: Users/Edit/5
		public async Task<IActionResult> Edit(int? id)
		{
			if (id == null || _context.User == null)
			{
				return NotFound();
			}

			var user = await _context.User.FindAsync(id);
			if (user == null)
			{
				return NotFound();
			}
			return View(user);
		}

		// POST: Users/Edit/5
		// To protect from overposting attacks, enable the specific properties you want to bind to.
		// For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
		[HttpPost]
		[ValidateAntiForgeryToken]
		public async Task<IActionResult> Edit(int id, [Bind("ID,Name,Email,Password,Role")] User user)
		{
			if (id != user.ID)
			{
				return NotFound();
			}

			if (ModelState.IsValid)
			{
				try
				{
					_context.Update(user);
					await _context.SaveChangesAsync();
				}
				catch (DbUpdateConcurrencyException)
				{
					if (!UserExists(user.ID))
					{
						return NotFound();
					}
					else
					{
						throw;
					}
				}
				return RedirectToAction(nameof(Index));
			}
			return View(user);
		}

		// GET: Users/Delete/5
		public async Task<IActionResult> Delete(int? id)
		{
			if (id == null || _context.User == null)
			{
				return NotFound();
			}

			var user = await _context.User
				.FirstOrDefaultAsync(m => m.ID == id);
			if (user == null)
			{
				return NotFound();
			}

			return View(user);
		}

		// POST: Users/Delete/5
		[HttpPost, ActionName("Delete")]
		[ValidateAntiForgeryToken]
		public async Task<IActionResult> DeleteConfirmed(int id)
		{
			if (_context.User == null)
			{
				return Problem("Entity set 'BTL_LWNC_WebAmNhacContext.User'  is null.");
			}
			var user = await _context.User.FindAsync(id);
			if (user != null)
			{
				_context.User.Remove(user);
			}
			
			await _context.SaveChangesAsync();
			return RedirectToAction(nameof(Index));
		}

		private bool UserExists(int id)
		{
		  return (_context.User?.Any(e => e.ID == id)).GetValueOrDefault();
		}
	}
}
