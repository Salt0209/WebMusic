using BTL_LWNC_WebAmNhac.Data;
using BTL_LWNC_WebAmNhac.Models;
using BTL_LWNC_WebAmNhac.Services.Interface;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace BTL_LWNC_WebAmNhac.Services
{
    public class HomeService : IHomeInterface
    {
        private readonly BTL_LWNC_WebAmNhacContext _context;
        public HomeService(BTL_LWNC_WebAmNhacContext context)
        {
            _context = context;
        }
        public List<Playlist> ListPlaylists(int? id)
        {
            try
            {
                var list = _context.Playlist.AsNoTracking();

                if (id != null)
                {
                    list = list.Where(p => p.GenreID == id);
                }

                return list.ToList();
            }
            catch (Exception ex)
            {
                throw new Exception("Error occurred while listing playlists.", ex);
            }
        }

        public List<object> ListRankingPlaylists(int? id)
        {
            try
            {
                var list = _context.Playlist.AsNoTracking();
                if (id != null)
                {
                    list = list.Where(p => p.GenreID == id);
                }
                var queryResult = list.OrderByDescending(p => p.ViewCount)
                      .Select(p => new
                      {
                          Id = p.ID,
                          Name = p.Name,
                          Artist = p.User.Name,
                          ViewCount = p.ViewCount
                      })
                      .ToList();
                var resultList = queryResult.Select(item => new
                {
                    // Ép kiểu dữ liệu nếu cần
                    Id = (int)item.Id,
                    Name = (string)item.Name,
                    Artist = (string)item.Artist,
                    ViewCount = (int)item.ViewCount
                }).ToList();
                return resultList.Cast<object>().ToList();
            }
            catch (Exception ex)
            {
                throw new Exception("Error occurred while listing playlists.", ex);
            }
        }
    }
}
