using BTL_LWNC_WebAmNhac.Controllers;
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
        private readonly IHttpContextAccessor _httpContextAccessor;
        public HomeService(BTL_LWNC_WebAmNhacContext context, IHttpContextAccessor httpContextAccessor)
        {
            _context = context;
            _httpContextAccessor = httpContextAccessor;
        }
        public List<object> ListPlaylists(int? id)
        {
            try
            {
                var list = _context.Playlist.AsNoTracking();

                if (id != null)
                {
                    list = list.Where(p => p.GenreID == id);
                }
                
                var queryResult = list
                      .Select(p => new
                      {
                          Id = p.ID,
                          Name = p.Name,
                          Artist = p.User.Name,
                          Thumbnail = p.Thumbnail,
                          Detail = p.Detail,
                          ViewCount = p.ViewCount,
                          IsFav = false
                      })
                      .ToList();
                var isFav = _httpContextAccessor.HttpContext.User.Identity.IsAuthenticated;
                if (isFav)
                {
                    var userId = Int32.Parse(_httpContextAccessor.HttpContext.User.FindFirst("UserId").Value);
                    var updatedQueryResult = queryResult.Select(p =>
                    {
                        var isFav = checkFav(userId, p.Id); // Calculate IsFav for each item
                        return new
                        {
                            p.Id,
                            p.Name,
                            p.Artist,
                            p.Thumbnail,
                            p.Detail,
                            IsFav = isFav // Update IsFav property
                        };
                    }).ToList();
                    return updatedQueryResult.Cast<object>().ToList();
                }
                return queryResult.Cast<object>().ToList();  
            }
            catch (Exception ex)
            {
                throw new Exception("Error occurred while listing playlists.", ex);
            }
        }
        public bool checkFav(int uid, int? pid)
        {

            return _context.UserFavourite.Any(p => p.UserID == uid &&
                p.PlaylistID==pid);
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

        public List<object> Search(string searchText)
        {
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

            return searchResults.Cast<object>().ToList();
        }
    }
}
