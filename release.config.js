const gitlab = [
  "@semantic-release/gitlab",
  {
    gitlabUrl: "https://git.stamus-networks.com",
    assets: [],
  },
];

const github = [
  "@semantic-release/github",
  {
    assets: [],
  },
];

// Determine the CI environment
const isGitLab = !!process.env.CI && !process.env.GITHUB_ACTIONS; // GitLab CI sets CI, GitHub Actions sets GITHUB_ACTIONS

/**
 * @type {import('semantic-release').GlobalConfig}
 */
module.exports = {
  tagFormat: "${version}",
  branches: ["main", { name: "next", prerelease: true }],
  plugins: [
    [
      "@semantic-release/commit-analyzer",
      {
        preset: "conventionalcommits",
      },
    ],
    "@semantic-release/release-notes-generator",
    [
      "@semantic-release/git",
      {
        message:
          "ci(release): release ${nextRelease.version}\n\n${nextRelease.notes}",
      },
    ],
    ...(isGitLab ? [gitlab] : [github]), // Dynamically select GitLab or GitHub
  ],
};
