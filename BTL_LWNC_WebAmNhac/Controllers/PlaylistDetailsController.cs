using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using BTL_LWNC_WebAmNhac.Data;
using BTL_LWNC_WebAmNhac.Models;
using Microsoft.AspNetCore.Authorization;

namespace BTL_LWNC_WebAmNhac.Controllers
{
    public class PlaylistDetailsController : Controller
    {
        private readonly BTL_LWNC_WebAmNhacContext _context;

        public PlaylistDetailsController(BTL_LWNC_WebAmNhacContext context)
        {
            _context = context;
        }

        public async Task<IActionResult> Playlist(int? id)
        {
            if (id == null || _context.PlaylistDetail == null)
            {
                return NotFound();
            }
            var playlistDetail = await _context.PlaylistDetail
                .Include(p => p.Playlist)
                .Include(p => p.Song).ThenInclude(s => s.Artist)
                .Include(p => p.Song).ThenInclude(s => s.Genre)
                .Where(m => m.PlaylistID == id)
                .ToListAsync();
            if (playlistDetail == null)
            {
                return NotFound();
            }
            var playlist = _context.Playlist.Find(id);
            if (playlist.ViewCount == null)
            {
                playlist.ViewCount = 0;
            }
            playlist.ViewCount++;
            _context.Update(playlist);
            _context.SaveChanges();

            return PartialView(playlistDetail);
        }
    }
}
