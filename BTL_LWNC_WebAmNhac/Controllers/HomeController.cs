using BTL_LWNC_WebAmNhac.Data;
using BTL_LWNC_WebAmNhac.Models;
using BTL_LWNC_WebAmNhac.Services.Interface;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Diagnostics;

namespace BTL_LWNC_WebAmNhac.Controllers
{
    public class HomeController : Controller
    {
        private readonly BTL_LWNC_WebAmNhacContext _context;

        IHomeInterface _homeService;

        public HomeController(BTL_LWNC_WebAmNhacContext context, IHomeInterface homeService)
        {
            _context = context;
            _homeService = homeService;
        }

        public async Task<IActionResult> Index()
        {
            return View();
        }
        [HttpGet]
        public JsonResult ListPlaylists(int? id)
        {
            try
            {
                List<Playlist> list = _homeService.ListPlaylists(id);
                return Json(new { code = 200, list = list, msg = "Lấy dữ liệu thành công" });
            }
            catch (Exception ex)
            {
                return Json(new { code = 500, msg = "Lấy dữ liệu thất bại:" + ex.Message });
            }
        }
        [HttpGet]
        public JsonResult LoadRankingPlaylists(int? id)
        {
            try
            {
                List<object> list = _homeService.ListRankingPlaylists(id);

                return Json(new { code = 200, list = list, msg = "Lấy dữ liệu thành công" });
            }
            catch (Exception ex)
            {
                return Json(new { code = 500, msg = "Lấy dữ liệu thất bại:" + ex.Message });
            }
        }

        [HttpGet]
        public IActionResult Search(string searchText)
        {
            // Tìm kiếm trong danh sách sản phẩm theo tên, giá, brand hoặc category
            var searchResults = _context.Playlist
                .Where(p => p.Name.Contains(searchText))
                .Select(p => new
                {
                    Id = p.ID,
                    Name = p.Name,
                    Artist = p.User.Name,
                    Thumbnail = p.Thumbnail
                })
            .ToList();

            return Json(new { code = 200, list = searchResults, msg = "Lấy dữ liệu thành công" });
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
        [Authorize(Roles ="Admin")]
        public IActionResult Admin()
        {
            return View();
        }
    }
}